if ($env:VIRTUAL_ENV) {
	deactivate
}

python -m venv "$PSScriptRoot\pvenv" --clear
& "$PSScriptRoot\pvenv\Scripts\Activate.ps1"
python -m pip install -r "$PSScriptRoot\requirements.txt"
conan install "$PSScriptRoot" -of "$PSScriptRoot\lbuild" --build=missing --update -c tools.env.virtualenv:powershell=True
& "$PSScriptRoot\lbuild\conanbuild.ps1"

cmake --workflow --preset=Compile
