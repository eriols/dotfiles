#!/usr/bin/env bash
#
# build-vim.sh — build & install Vim from source with my usual feature set,
# now including native Wayland clipboard support.
#
# The Wayland clipboard (the +wayland_clipboard feature, chosen at runtime via
# the 'clipmethod' option) was added upstream in patch 9.1.1485, so the source
# tree must be at least that recent. Needs the Wayland dev headers
# (Fedora: wayland-devel, Ubuntu: libwayland-dev) present at configure time.
#
# Usage:
#   ./build-vim.sh [VIM_SRC]      # default VIM_SRC=~/code/vim
#   NO_UPDATE=1 ./build-vim.sh    # rebuild the current checkout, skip git update
#
set -euo pipefail

# Run this as your normal user — only 'make install' below needs root (it calls
# sudo itself). Running the whole script under sudo sets $HOME=/root (so the
# source path resolves wrong) and leaves root-owned objects in the tree.
if [ "$(id -u)" -eq 0 ]; then
    echo "build-vim: run this as your normal user, not with sudo." >&2
    echo "  It already calls sudo itself, only for 'make install'." >&2
    exit 1
fi

VIM_SRC="${1:-$HOME/code/vim}"
cd "$VIM_SRC"

# Pull the latest upstream patches unless asked to rebuild the current checkout.
# (Fast-forward only: refuses to run if the local tree has diverged.)
if [ "${NO_UPDATE:-0}" != "1" ]; then
    git fetch origin
    git merge --ff-only origin/master
fi

make distclean

CFLAGS=-fPIC ./configure \
    --enable-cscope \
    --with-features=huge \
    --enable-python3interp=yes \
    --with-python3-config-dir="$(python3-config --configdir)" \
    --with-x \
    --with-wayland

make

# Don't install unless the Wayland clipboard actually made it into the build.
if ./src/vim --version | grep -q '+wayland_clipboard'; then
    echo "build-vim: +wayland_clipboard present — good."
else
    echo "build-vim: ERROR — +wayland_clipboard missing from this build." >&2
    echo "  Check the ./configure output above for Wayland detection" >&2
    echo "  (wayland-devel / libwayland-dev must be installed)." >&2
    exit 1
fi

sudo make install

echo "build-vim: installed."
command -v vim
vim --version | head -1
