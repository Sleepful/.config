#!/bin/bash

session="who_serve"
if [[ $(tmux has-session $session) == 1 ]]; then
	jump $session
else
	tmux new-session -d -s $session
	window=1
	tmux rename-window -t $session:$window 'docker'
	tmux send-keys -t $session:$window 'cd wholesale && docker-compose up' C-m
	window=2
	tmux new-window -t $session:$window -n 'phx_who'
	tmux send-keys -t $session:$window 'cd wholesale && mix phx.server' C-m
	window=3
	tmux new-window -t $session:$window -n 'node_who'
	tmux send-keys -t $session:$window 'cd club-who && yarn serve' C-m
	tmux detach -E "tmux attach -t $session"
	jump $session
fi
