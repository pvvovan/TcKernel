cmake_minimum_required(VERSION 4.4.3)

project(tcapp LANGUAGES CXX)

add_library(mylib STATIC)

set_target_properties(mylib PROPERTIES
	CXX_STANDARD		17
	CXX_STANDARD_REQUIRED	ON
	CXX_EXTENSIONS		OFF
)

target_sources(mylib PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}/Src/main.cpp
)
