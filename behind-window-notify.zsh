
autoload -Uz add-zsh-hook

function remenber-cmd(){
    export LASTCMD=$1
}

add-zsh-hook preexec remenber-cmd

function behind-window-notify(){
  if [[ -n $TMUX ]] then
    for pane in `tmux list-panes -F'#{pane_id}'`; do
      if [[ $pane == $TMUX_PANE ]] then
        return 0
      fi
    done
    
    notify-send -t 3000 -u low "コマンド終了: " "$LASTCMD"
  fi
}

add-zsh-hook precmd behind-window-notify
