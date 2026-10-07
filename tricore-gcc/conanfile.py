import os
import tempfile

from conan import ConanFile
from conan.errors import ConanInvalidConfiguration
from conan.tools.files import copy, download, unzip
from urllib.parse import urljoin

required_conan_version = ">=2.32"


class TriCoreGccConan(ConanFile):
	name = "tricore-gcc"
	version = "13.4.1-1"
	package_type = "application"
	settings = "arch", "os"
	exports = "tricoregcc.cmake"
	zipfile = None

	def validate(self):
		if self.settings.arch != "x86_64":
			raise ConanInvalidConfiguration("GCC binaries are only provided for x86_64")
		if self.settings.os not in ["Linux", "Windows"]:
			raise ConanInvalidConfiguration("GCC binaries are only provided for Windows and Linux")

	def build(self):
		source_entry = self.conan_data["sources"]["v13.4.1"][str(self.settings.os)]
		self.zipfile = os.path.join(tempfile.gettempdir(), "tricore-gcc-tempdir", source_entry["file"])
		if not os.path.isfile(self.zipfile):
			download(self,
				url = urljoin(source_entry["url"], source_entry["file"]),
				filename = self.zipfile,
				sha256 = source_entry["sha256"])

	def package(self):
		unzip(self,
			filename = self.zipfile,
			destination = self.package_folder,
			keep_permissions = True,
			strip_root = True if self.settings.os == "Linux" else False)
		copy(self, "tricoregcc.cmake", self.recipe_folder, self.package_folder)

	def package_info(self):
		self.cpp_info.bindirs = ["bin"]
		self.cpp_info.includedirs = []
		self.cpp_info.libdirs = []

		for flags in ["cflags", "cxxflags", "asmflags"]:
			self.conf_info.append(f"tools.build:{flags}", "-mtc162")

		self.conf_info.define("tools.cmake.cmaketoolchain:user_toolchain",
					[os.path.join(self.package_folder, "tricoregcc.cmake")])

		# TODO: link pthread library statically in tricore-gcc build
		if self.settings.os == "Windows":
			git_install_path = self._get_git_install_path()
			lib_pthread_dir = os.path.join(git_install_path, "mingw64", "bin")
			if not os.path.isfile(os.path.join(lib_pthread_dir, "libwinpthread-1.dll")):
				raise ConanInvalidConfiguration("Failed to locate libwinpthread-1.dll")
			self.buildenv_info.prepend_path("PATH", lib_pthread_dir)

	def _get_git_install_path(self):
		import winreg
		targets = [
			(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\GitForWindows", winreg.KEY_WOW64_64KEY),
			(winreg.HKEY_CURRENT_USER, r"SOFTWARE\GitForWindows", 0),
			(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\GitForWindows", winreg.KEY_WOW64_32KEY)
		]

		for hive, path, flag in targets:
			try:
				key = winreg.OpenKey(hive, path, 0, winreg.KEY_READ | flag)
				git_install_path, _ = winreg.QueryValueEx(key, "InstallPath")
				return git_install_path
			except FileNotFoundError:
				continue

		raise FileNotFoundError("Git for Windows registry key could not be found in HKLM or HKCU.")
