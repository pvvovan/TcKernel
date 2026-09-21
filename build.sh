#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cmake \
	-S "${SCRIPT_DIR}" \
	-B "${SCRIPT_DIR}/lbuild" \
	-G Ninja \
	-D CMAKE_BUILD_TYPE=Debug \
	--toolchain "${SCRIPT_DIR}/lbuild/conan_toolchain.cmake"

cmake \
	--build "${SCRIPT_DIR}/lbuild" \
	--verbose
