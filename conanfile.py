from conan import ConanFile
from conan.tools.files import save
from os import path

required_conan_version = ">=2.33"

class TcApp(ConanFile):
	name = "TcApp"
	version = "1.0.1"
	package_type = "application"
	settings = "os", "arch", "build_type"
	generators = "VirtualBuildEnv", "VirtualRunEnv"

	def requirements(self):
		self.tool_requires("bazel-pkg/9.3.2@tc/gcc")
		self.tool_requires("tricore-gcc/13.4.1-6@tc/gcc")

	def generate(self):
		tc_gcc_dir = self.dependencies.build["tricore-gcc"].package_folder.replace("\\", "/")
		save(self, path.join(self.generators_folder, "conan.bazelrc"),
			f"common --override_module=tricore_gcc={tc_gcc_dir}\n" +
			f"common --action_env=tricore_gcc_dir={tc_gcc_dir}\n"
		)
