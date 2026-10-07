add_library(freertos_kernel_port OBJECT)

set_target_properties(freertos_kernel_port PROPERTIES
	C_STANDARD		17
	C_STANDARD_REQUIRED	ON
	C_EXTENSIONS		OFF
)

target_sources(freertos_kernel_port PRIVATE
	port.c
)

add_library(freertos_kernel_port_headers INTERFACE)

target_include_directories(freertos_kernel_port_headers INTERFACE 
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(freertos_kernel_port PRIVATE
	freertos_kernel_port_headers
	freertos_kernel_include
)
