if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx -- vt1 -keeptty > ~/.local/share/xorg/xorg.log 2>&1
fi

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
