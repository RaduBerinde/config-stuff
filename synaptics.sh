#!/bin/sh

# To get this to work:
#  - in /etc/modprobe.d/blacklist.conf add:
#      # Remove SynPS/2 Synaptics Touchpad driver.
#      blacklist psmouse
#
#  - in /usr/share/X11/xorg.conf.d, move 50-synaptics to 95-synaptics
#    (so it's after libinput and is preferred).


synclient TapButton2=2
synclient TapButton3=3
synclient ClickFinger2=2
synclient ClickFinger3=3
synclient PalmDetect=1
synclient PalmMinWidth=2
synclient PalmMinZ=50
syndaemon -i 0.3 -d -t
