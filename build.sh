#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "${SCRIPT_DIR}"

bazel build //Src:my-app # --subcommands=pretty_print

bazel aquery --output=jsonproto 'mnemonic("CppCompile", deps(//Src:my-app))' > ./lbuild/protobuild.json
python3 ./compile_commands.py "${SCRIPT_DIR}/lbuild/protobuild.json" "${SCRIPT_DIR}/lbuild/compile_commands.json"
