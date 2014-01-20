
autoload -Uz add-zsh-hook

function remenber-cmd(){
    export LASTCMD=$1
}

add-zsh-hook preexec remenber-cmd

function behind-window-notify(){
  if [[ -n $TMUX ]] then
    panes=`tmux list-panes -F'#{pane_id}'`

    if test -z ${(M)panes#$TMUX_PANE}; then
      if [[ ${OSTYPE} == darwin* ]] then
        # TODO: OSX用にgrowlを呼ぶ処理.
      else
	notify-send -t 3000 -u low "コマンド終了: " "$LASTCMD"
      fi
    fi
  fi
}

add-zsh-hook precmd behind-window-notify
