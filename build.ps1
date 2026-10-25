if ($env:VIRTUAL_ENV) {
	deactivate
}

& {
	cd "$PSScriptRoot"
	python -m venv pvenv --clear
	& pvenv\Scripts\Activate.ps1
	python -m pip install -r requirements.txt
	conan install . --update --output-folder=lbuild --build=missing -c tools.env.virtualenv:powershell=True
	& lbuild\conanbuild.ps1

	cmake --workflow --preset=Compile
}
