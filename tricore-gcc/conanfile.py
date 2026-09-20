import os
import tempfile

from conan import ConanFile
from conan.tools.files import copy, download, unzip
from urllib.parse import urljoin

required_conan_version = ">=2.32"


class TriCoreGccConan(ConanFile):
	name = "tricore-gcc"
	settings = "arch", "os"
	version = "13.4.1-0"
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
			strip_root = True)
