#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  --not-when-audio \
  `# Dim the screen after 300 seconds (5 min), undim if user becomes active` \
  --timer 300 \
    "/usr/bin/light -S 10" \
    "/usr/bin/light -S 70" \
  `# Undim & lock after 300 more seconds (5 min)` \
  --timer 300 \
    "/usr/bin/light -S 50 && /home/eugene/.config/awesome/scripts/i3locker.sh" \
    "/usr/bin/light -S 70" \
  `# Finally, suspend an 1800 seconds (30 min) after it locks` \
  --timer 1800 \
    "systemctl hybrid-sleep" \
    "/usr/bin/light -S 70"
