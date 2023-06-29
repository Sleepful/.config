#!/bin/bash

id="pro"
session=echo $id"_serve"
dir="alliance-pro"
if [[ $(tmux has-session $session) == 1 ]]; then
	jump $session
else
	tmux new-session -d -s $session
	window=1
	tmux rename-window -t $session:$window 'docker'
	tmux send-keys -t $session:$window "cd $dir && docker compose up" C-m
	window=2
	tmux new-window -t $session:$window -n "phx_$id"
	tmux send-keys -t $session:$window "cd $dir && mix phx.server" C-m
	window=3
	tmux new-window -t $session:$window -n "node_$id"
	tmux send-keys -t $session:$window "cd $dir && cd admin_ui && npm run dev" C-m
	tmux detach -E "tmux attach -t $session"
	jump $session
fi
