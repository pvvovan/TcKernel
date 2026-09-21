set(CMAKE_SYSTEM_NAME		Generic)

set(CMAKE_C_COMPILER_ID		GNU)
set(CMAKE_CXX_COMPILER_ID	GNU)

set(TOOLCHAIN_PREFIX		tricore-elf-)

set(CMAKE_C_COMPILER		${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER		${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER		${TOOLCHAIN_PREFIX}g++)
set(CMAKE_LINKER		${TOOLCHAIN_PREFIX}g++)
set(CMAKE_OBJCOPY		${TOOLCHAIN_PREFIX}objcopy)
set(CMAKE_SIZE			${TOOLCHAIN_PREFIX}size)

set(CMAKE_EXECUTABLE_SUFFIX_ASM	".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C	".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX	".elf")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_C_FLAGS_DEBUG "-O0 -g3 -gdwarf-5")
set(CMAKE_C_FLAGS_RELEASE "-O3 -g0")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3 -gdwarf-5")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -g0")

add_compile_options(
	-fno-common
	-ffunction-sections
	-fstrict-volatile-bitfields
	-fstack-usage
	-fcallgraph-info
	-Wall
	-Wextra
	-Wconversion
	-Wsign-conversion
	$<$<COMPILE_LANGUAGE:ASM>:-x>
	$<$<COMPILE_LANGUAGE:ASM>:assembler-with-cpp>
	$<$<COMPILE_LANGUAGE:ASM>:-MMD>
	$<$<COMPILE_LANGUAGE:ASM>:-MP>
	$<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
	$<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
	$<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
)

add_link_options(
	-nocrt0
	-Wl,--cref
	-Wl,--gc-sections
	-Wl,-Map=${CMAKE_PROJECT_NAME}.map
	-Wl,--orphan-handling=error
	-Wl,--print-memory-usage
	-Wl,--print-map-locals
)
