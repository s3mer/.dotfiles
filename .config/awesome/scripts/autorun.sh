#!/usr/bin/env bash

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run /usr/bin/sbxkb
run /usr/bin/picom
run /usr/bin/nm-applet
run /usr/bin/pasystray --volume-max=100 --notify=all
#run /usr/bin/cbatticon --icon-type standard --low-level 20 --critical-level 5
run /usr/bin/blueman-applet
run /usr/bin/udiskie
run /home/$USER/.config/awesome/scripts/xidlehook.sh
run /usr/bin/conky
run /usr/bin/alacritty
#run /usr/bin/setxkbmap -layout "us,ua" -option "grp:alt_shift_toggle"

