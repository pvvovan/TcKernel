def main():
	import json
	import os
	import sys
	from pathlib import Path

	if len(sys.argv) < 3:
		print("Usage: compile_commands.py <path_to_protobuild.json> <path_to_compile_commands.json>")
		sys.exit(1)

	protobuild_path = sys.argv[1]
	compile_commands_path = sys.argv[2]

	if not os.path.exists(protobuild_path):
		print(f"File not found: {protobuild_path}")
		sys.exit(1)

	with open(protobuild_path, 'r') as f:
		data = json.load(f)

	compile_commands = []
	directory = Path.cwd().as_posix()

	for action in data.get('actions', []):
		args = action.get('arguments')
		compile_commands.append({
			'directory': directory,
			'arguments': args,
			'file': args[args.index('-c') + 1],
		})

	with open(compile_commands_path, 'w') as f:
		json.dump(compile_commands, f, indent=2)

if __name__ == "__main__":
	main()
