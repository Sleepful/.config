#!/bin/bash
#
function move_windows() {
	windows=$(
		tmux list-windows -F "#{window_active} #{window_index} #{window_name}" | sort -r | awk '{print $2 " : " $3}' | fzf-tmux -p | awk '{print $1}' | sort -r
	)
	if [ -n "$windows" ]; then
		session=$(tmux list-sessions -F '#{session_attached} #{session_name}' | sort -r | awk '{print $2}' | fzf-tmux -p | awk '{print $1}')
		current_session=$(tmux display-message -p '#S')
		echo $windows | xargs -n1 -I {i} tmux move-window -b -s "$current_session":{i} -t "$session":1
	fi
}
function session_picker() {
	tmux list-sessions -F '#{session_attached} #{session_name}' | sort -r | awk '{print $2}' | fzf-tmux -p | xargs tmux switchc -t
}

close_session() {
	# switch session and kill previous one
	session_to_discard=$(tmux display -p '#S')
	tmux detach -E "tmux kill-session -t $session_to_discard && tmux attach"
}
