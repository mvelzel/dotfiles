#!/bin/sh
if [ $# -ge 1 ]
then
    cd $1
fi
tmux split-window -v
tmux resize-pane -y 12
tmux split-window -h
tmux send-keys cd Enter
for _pane in $(tmux list-panes -F '#P'); do
    tmux send-keys -t ${_pane} "clear" Enter
done
tmux send-keys -t 0 'vim' Enter
tmux select-pane -t 0
