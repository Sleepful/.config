#!/usr/bin/env bash

# elixir
brew install asdf
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
# erlang pre-reqs, must be there at the
# time that erlang gets compiled
brew install wxmac
brew install unixodbc # seems like this isn't working
# because the erlang install command says obdc check failed
brew install fop # for pdf documentation generation
asdf install erlang latest
asdf install elixir latest
asdf global erlang latest
asdf global elixir latest

# must do something like:
# echo "erlang 25.0.1" >> .tool-versions
# in order to run `$ mix` command

mix local.hex
mix archive.install hex phx_new
