cmake_minimum_required(VERSION 4.4.3)

project(tcapp LANGUAGES ASM C CXX)

add_library(mylib STATIC)

set_target_properties(mylib PROPERTIES
	CXX_STANDARD		17
	CXX_STANDARD_REQUIRED	ON
	CXX_EXTENSIONS		OFF
)

target_sources(mylib PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}/Src/main.cpp
)

set(GENERATED_LINKER_SCRIPT ${CMAKE_BINARY_DIR}/myapp.ld)
set(LINKER_SCRIPT_TEMPLATE ${CMAKE_CURRENT_SOURCE_DIR}/myapp.ld)

add_custom_command(
	OUTPUT ${GENERATED_LINKER_SCRIPT}
	DEPENDS ${LINKER_SCRIPT_TEMPLATE}
	COMMAND ${CMAKE_C_COMPILER} -undef -E -P -x c
		"${LINKER_SCRIPT_TEMPLATE}"
		-o "${GENERATED_LINKER_SCRIPT}"
)

add_custom_target(generate_linker_script
	DEPENDS ${GENERATED_LINKER_SCRIPT}
)

add_executable(myapp)

target_sources(myapp PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}/startup.s
)

set_target_properties(myapp PROPERTIES LINK_DEPENDS ${GENERATED_LINKER_SCRIPT})
target_link_options(myapp PRIVATE -T ${GENERATED_LINKER_SCRIPT})
add_dependencies(myapp generate_linker_script)

target_link_libraries(myapp PRIVATE mylib)
