if ($env:VIRTUAL_ENV) {
	deactivate
}

& {
	Push-Location "$PSScriptRoot"
	cd "$PSScriptRoot"
	python -m venv pvenv --clear
	& pvenv\Scripts\Activate.ps1
	python -m pip install -r requirements.txt
	conan install . --update --output-folder=lbuild --build=missing -c tools.env.virtualenv:powershell=True
	& lbuild\conanbuild.ps1

	bazel build //Src:my-app

	$jsonData = bazel aquery --output=jsonproto 'mnemonic("CppCompile", deps(//Src:my-app))' | Out-String
	$unf8NoBom = New-Object System.Text.UTF8Encoding($False)
	[System.IO.File]::WriteAllText("lbuild\protobuild.json", $jsonData, $unf8NoBom)
	python compile_commands.py lbuild\protobuild.json lbuild\compile_commands.json

	Pop-Location
}
