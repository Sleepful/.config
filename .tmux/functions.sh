#!/bin/bash
#
source ~/.profile.subshell

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

function close_session() {
	# switch session and kill previous one
	session_to_discard=$(tmux display -p '#S')
	tmux detach -E "tmux kill-session -t $session_to_discard && tmux attach"
}

function open_notes() {
	notes=$(ls -d1 $PARK*/*/)
	notes_without_root=$(echo "$notes" | sed -E 's|.+/([A-Za-z]+/[A-Za-z]+)/$|\1|g')
	# pass the notes_without_root, and then echo the root
	selection_without_root=$(echo "$notes_without_root" | fzf-tmux -p)
	if [[ -z $selection_without_root ]]; then
		return
	fi
	selection=$(echo $PARK$selection_without_root)
	leaf=$(echo $selection | sed -E 's|.+/(.+)$|\1|g')
	session=notes
	window=1
	if [[ $(pgrep -f "nvim.*$selection") ]]; then
		# Grab PID by grepping the path of the notes
		# because we include path in the command with which
		# nvim starts, so it shows inside `ps`.
		# Additionally, use sed to grab the first line, because for some
		# odd reason there will be two results for the same pane
		pid=$(pgrep -f "nvim.*$selection" | sed -n 1p)
		# Use `ps` to find the `ttys` of the `pid` that we found earlier
		# the `ttys` will be used to find the correct tmux pane that we must jump to.
		# Remember to use ^ on the regex so that we match the PID and avoid matching
		# the process that has the same PID as a CMD argument. Also use AWK to get the
		# TTYS column of the result
		ttys=$(ps | grep "^$pid" | awk '{print $2}')
		# got this from  this nice place: https://stackoverflow.com/questions/29439835/find-tmux-session-that-a-pid-belongs-to
		pane_id=$(tmux list-panes -aF "#{pane_tty}:#{pane_id}" | grep $ttys | grep -oE "[^:]*$")
		# finally, lets switch to the already-existing nvim instance
		tmux switch-client -t $pane_id
	else
		if tmux has-session -t $session; then
			# switch to session and create a new window
			tmux new-window -bt $session:$window -n $leaf
			tmux switch-client -t $session
		else
			# create new session and use default window
			tmux new-session -s $session -d
			tmux switch-client -t $session
			tmux rename-window -t $session:$window $leaf
		fi

		vim_cmd="vim -c \"lua require('plugins.kasten.functions').require_kasten('$selection')\""
		tmux send-keys -t $session:$window "cd $selection && $vim_cmd" C-m
	fi
}
