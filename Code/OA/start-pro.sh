#!/bin/bash

id=pro
session="$id"_sh
dir=alliance-pro
if [[ $(tmux has-session $session) == 1 ]]; then
	jump $session
else
	# shell session
	tmux new-session -d -s $session
	window=1
	tmux rename-window -t $session:$window 'docker'
	tmux send-keys -t $session:$window "cd $dir && docker compose up" C-m
	window=2
	tmux new-window -t $session:$window -n phx
	tmux send-keys -t $session:$window "cd $dir && mix phx.server" C-m
	window=3
	tmux new-window -t $session:$window -n node
	tmux send-keys -t $session:$window "cd $dir && cd admin_ui && npm run dev" C-m
	window=4
	tmux new-window -t $session:$window -n typecheck
	# tsc-watch requires `npm -i tsc-watch`
	tmux send-keys -t $session:$window "cd $dir && cd admin_ui && tsc-watch" C-m
	window=5
	tmux new-window -t $session:$window -n codegen
	tmux send-keys -t $session:$window "cd $dir && cd admin_ui && sleep 10 && npm run codegen" C-m
	window=6
	tmux new-window -t $session:$window -n storybook
	tmux send-keys -t $session:$window "cd $dir && cd admin_ui && npm run storybook" C-m
	# attach to this session after all is done
	tmux detach -E "tmux attach -t $session"
	code_session="$id"_c
	tmux new-session -d -s $code_session
	window=1
	tmux rename-window -t $code_session:$window 'code'
	tmux send-keys -t $code_session:$window "cd $dir" C-m
fi
