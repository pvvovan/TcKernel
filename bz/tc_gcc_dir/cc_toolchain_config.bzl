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

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "{}/bin/tricore-elf-gcc".format(ctx.configuration.default_shell_env.get("tricore_gcc_dir")),
        ),
        tool_path(
            name = "ld",
            path = "/bin/false",
        ),
        tool_path(
            name = "ar",
            path = "{}/bin/tricore-elf-ar".format(ctx.configuration.default_shell_env.get("tricore_gcc_dir")),
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
            name = "default_compile_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_compile_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-fdata-sections",
                                "-ffunction-sections",
                                "-fno-common",
                                "-fstrict-volatile-bitfields",
                            ]
                        ),
                    ]),
                ),
                flag_set(
                    actions = [ACTION_NAMES.cpp_compile],
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-fno-exceptions",
                                "-fno-rtti",
                                "-fno-threadsafe-statics",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
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
                                "-nocrt0",
                                "-Wl,--cref",
                                "-Wl,--gc-sections",
                                "-Wl,--orphan-handling=error",
                                "-Wl,--print-map-locals",
                                "-Wl,--print-memory-usage",
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
                            ],
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
                            ],
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
            "{}/tricore-elf/include".format(ctx.configuration.default_shell_env.get("tricore_gcc_dir")),
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
    provides = [CcToolchainConfigInfo],
)
