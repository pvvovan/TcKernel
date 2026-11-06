#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}"

bazel=/home/vovan/Downloads/bazel-9.3.2-linux-x86_64

$bazel build -s //main:my-world
