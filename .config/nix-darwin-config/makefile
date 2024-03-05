# first time run this command
bootstrap:
	nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake .

# run this after making changes
rebuild:
	darwin-rebuild switch --flake .
run: rebuild
