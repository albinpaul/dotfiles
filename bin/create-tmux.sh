#/bin/bash
set -x
CODE_DIR=~/IdeaProjects
cd $CODE_DIR

session=$(ls | fzf)
cd $session
cd src
window=$(ls | fzf)

tmux has-session -t $session 2>/dev/null

if [[ $? != 0 ]]; then
    tmux new-session -d -s $session -n $window -c $CODE_DIR
    tmux send-keys -t $session:$window "cd ${CODE_DIR}/$session; cd src;cd $window; clear" Enter
    if [[ -z "$TMUX" ]];  then
            tmux attach -t $session:$window
    else
            tmux switch-client -t $session:$window
    fi
else
    tmux new-window -a -d -n $window -t $session
    tmux send-keys -t $session:$window "cd ${CODE_DIR}/$session; cd src;cd $window; clear" Enter
    if [[ -z "$TMUX" ]];  then
            tmux attach -t $session:$window
    else
            tmux switch-client -t $session:$window
    fi
fi