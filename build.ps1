if ($env:VIRTUAL_ENV) {
	deactivate
}

python -m venv "$PSScriptRoot\pvenv" --clear
& "$PSScriptRoot\pvenv\Scripts\Activate.ps1"
python -m pip install -r "$PSScriptRoot\requirements.txt"
conan install -u "$PSScriptRoot" -of "$PSScriptRoot\lbuild" -b missing -c tools.env.virtualenv:powershell=True
& "$PSScriptRoot\lbuild\conanbuild.ps1"

cmake --workflow --preset=Compile
