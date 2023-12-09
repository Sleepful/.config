#!/bin/bash

session="uso_serve"
if [[ $(tmux has-session $session) == 1 ]]; then
	jump $session
else
	tmux new-session -d -s $session
	window=1
	tmux rename-window -t $session:$window 'docker'
	tmux send-keys -t $session:$window 'cd elixir-uso && docker-compose up' C-m
	window=2
	tmux new-window -t $session:$window -n 'phx_uso'
	tmux send-keys -t $session:$window 'cd elixir-uso && mix phx.server' C-m
	window=3
	tmux new-window -t $session:$window -n 'node_uso'
	tmux send-keys -t $session:$window 'cd node-uso && yarn serve' C-m
	tmux detach -E "tmux attach -t $session"
	jump $session
fi
