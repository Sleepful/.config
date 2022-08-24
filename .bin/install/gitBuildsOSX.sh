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

# Clojure
brew install clojure
# Babashka
brew install borkdude/brew/babashka
# Parinfer rust
cd $DIR
# git clone --depth 1 git@github.com:justinbarclay/parinfer-rust-mode.git
git clone --depth 1 https://github.com/eraserhd/parinfer-rust.git
cd parinfer-rust
cargo build --release --features emacs
cp target/release/libparinfer_rust.dylib ~/.emacs.d/.local/etc/parinfer-rust/parinfer-rust-darwin.so
