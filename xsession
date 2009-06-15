gnome-settings-daemon &
gnome-power-manager &
nm-applet &
xset b off
tomboy &
sleep 10 && emacs & # sleep so that gsd sets theme properly beforehand

export OOO_FORCE_DESKTOP=gnome # sigh

awesome
