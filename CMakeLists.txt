cmake_minimum_required(VERSION 4.4.3)

project(tcapp LANGUAGES ASM C CXX)

add_subdirectory(InfineonLibraries)

set(FREERTOS_HEAP "4" CACHE STRING "" FORCE)
set(FREERTOS_PORT "A_CUSTOM_PORT" CACHE STRING "" FORCE)
add_subdirectory(FreeRTOS-Config)
add_subdirectory(FreeRTOS-Port)
add_subdirectory(FreeRTOS-Kernel)

set_target_properties(freertos_kernel PROPERTIES
	C_STANDARD		17
	C_STANDARD_REQUIRED	ON
	C_EXTENSIONS		OFF
)

add_executable(myapp)

set_target_properties(myapp PROPERTIES
	CXX_STANDARD		23
	CXX_STANDARD_REQUIRED	ON
	CXX_EXTENSIONS		OFF
)

target_sources(myapp PRIVATE
	Src/main.cpp
	Src/Isr/inttab0.s
	Src/Trap/traptab0.s
)

target_link_libraries(myapp PRIVATE
	freertos_kernel
	IFX::ILLD
)

set(GENERATED_LINKER_SCRIPT ${CMAKE_BINARY_DIR}/myapp.ld)
set(LINKER_SCRIPT_TEMPLATE ${CMAKE_CURRENT_SOURCE_DIR}/Src/myapp.ld)

add_custom_command(
	OUTPUT ${GENERATED_LINKER_SCRIPT}
	DEPENDS ${LINKER_SCRIPT_TEMPLATE}
		${CMAKE_CURRENT_SOURCE_DIR}/Src/common.ld
	COMMAND ${CMAKE_C_COMPILER} -undef -E -P -x c
		"${LINKER_SCRIPT_TEMPLATE}"
		-o "${GENERATED_LINKER_SCRIPT}"
)

add_custom_target(generate_linker_script
	DEPENDS ${GENERATED_LINKER_SCRIPT}
)

set_property(TARGET myapp APPEND PROPERTY LINK_DEPENDS ${GENERATED_LINKER_SCRIPT})
target_link_options(myapp PRIVATE -T ${GENERATED_LINKER_SCRIPT})
add_dependencies(myapp generate_linker_script)
target_link_directories(myapp PRIVATE ${tcapp_SOURCE_DIR}/Src)
