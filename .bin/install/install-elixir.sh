#!/usr/bin/env bash

# elixir
brew install asdf
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install erlang latest
asdf install elixir latest
asdf global erlang latest
asdf global elixir latest
