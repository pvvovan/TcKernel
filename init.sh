#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

python3 -m venv "${SCRIPT_DIR}/pvenv"
. "${SCRIPT_DIR}/pvenv/bin/activate"
python3 -m pip install -r "${SCRIPT_DIR}/requirements.txt"
conan profile detect > /dev/null 2>&1 || true
conan install "${SCRIPT_DIR}" --output-folder="${SCRIPT_DIR}/lbuild" --build=missing --update
. "${SCRIPT_DIR}/lbuild/conanbuild.sh"
