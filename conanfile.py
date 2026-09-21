from conan import ConanFile
from conan.tools.cmake import CMakeToolchain

class TcApp(ConanFile):
	name = "TcApp"
	version = "0.0.1"
	package_type = "application"
	settings = "os", "arch", "build_type"
	generators = "VirtualBuildEnv", "VirtualRunEnv"

	def requirements(self):
		self.tool_requires("cmake/4.4.3")
		self.tool_requires("ninja/1.13.2")
		self.tool_requires("tricore-gcc/13.4.1-0@tc/gcc")

	def generate(self):
		tc = CMakeToolchain(self)
		tc.user_presets_path = False
		tc.generate()
