#!/bin/bash
# Symlink dotfiles from this repo into $HOME. Idempotent — safe to re-run.
set -eu

# Repo location, derived from this script so it works wherever it's cloned.
dir="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

# Home dotfiles: ~/.<name> -> <repo>/.<name>
dotfiles=".bashrc .bash_profile .bash_aliases .inputrc .ctags .gdbinit \
          .psqlrc .pylintrc .vimrc .xinitrc .xsession"

for f in $dotfiles; do
	echo "linking ~/$f -> $dir/$f"
	ln -sfn "$dir/$f" "$HOME/$f"
done

# Executables: ~/.local/bin/<name> -> <repo>/bin/<name>
mkdir -p "$HOME/.local/bin"
for exe in "$dir"/bin/*; do
	[ -f "$exe" ] || continue
	name="$(basename "$exe")"
	echo "linking ~/.local/bin/$name -> $exe"
	ln -sfn "$exe" "$HOME/.local/bin/$name"
done
