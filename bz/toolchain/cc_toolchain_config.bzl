load("@rules_cc//cc:action_names.bzl", "ACTION_NAMES")

load(
    "@rules_cc//cc:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

load("@rules_cc//cc/common:cc_common.bzl", "cc_common")
load("@rules_cc//cc/toolchains:cc_toolchain_config_info.bzl", "CcToolchainConfigInfo")

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
]

all_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
]

common_compile_options = [
    "-fdata-sections",
    "-ffunction-sections",
    "-fno-common",
    "-fstrict-volatile-bitfields",
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "/home/vovan/.conan2/p/b/tricofcdb7a014eeed/p/bin/tricore-elf-gcc",
        ),
        tool_path(
            name = "ld",
            path = "/bin/false",
        ),
        tool_path(
            name = "ar",
            path = "/home/vovan/.conan2/p/b/tricofcdb7a014eeed/p/bin/tricore-elf-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/bin/false",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "/bin/false",
        ),
        tool_path(
            name = "objdump",
            path = "/bin/false",
        ),
        tool_path(
            name = "strip",
            path = "/bin/false",
        ),
    ]

    features = [
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-lstdc++",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
        feature(
            name = "dbg",
            flag_sets = [
                flag_set(
                    actions = all_compile_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-g3",
                                "-gdwarf-5",
                                "-O0",
                            ] + common_compile_options,
                        ),
                    ]),
                ),
            ],
        ),
        feature(
            name = "opt",
            flag_sets = [
                flag_set(
                    actions = all_compile_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-g0",
                                "-O3",
                            ] + common_compile_options,
                        ),
                    ]),
                ),
            ],
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = [
            "/home/vovan/.conan2/p/b/tricofcdb7a014eeed/p/tricore-elf/include",
        ],
        toolchain_identifier = "local",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "tricore",
        target_libc = "unknown",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
