if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx -- vt1 -keeptty > ~/.local/share/xorg/xorg.log 2>&1
fi
