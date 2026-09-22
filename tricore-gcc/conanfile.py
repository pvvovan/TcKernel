import os
import tempfile

from conan import ConanFile
from conan.tools.files import copy, download, unzip
from urllib.parse import urljoin

required_conan_version = ">=2.32"


class TriCoreGccConan(ConanFile):
	name = "tricore-gcc"
	version = "13.4.1-0"
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
