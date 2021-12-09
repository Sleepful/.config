#!/usr/bin/env bash

DIR=~/Code/GitBuilds

cd $DIR
git clone --depth 1 git@github.com:dexpota/kitty-themes.git

# Elixir language server
git clone --depth 1 git@github.com:elixir-lsp/elixir-ls.git
cd ./elixir-ls
mix deps.get
mix compile
mix elixir_ls.release -o ../elixir-ls-`asdf current | grep elixir | tr -s " " | cut -d " " -f 2 | sed 's/\.[^\..*]-.*//g'`
