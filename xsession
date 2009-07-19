gnome-settings-daemon &
gnome-power-manager &
/usr/bin/pulseaudio --start --log-target=syslog &
nm-applet &
xset b off
tomboy &
sleep 10 && emacs & # sleep so that gsd sets theme properly beforehand

export OOO_FORCE_DESKTOP=gnome # sigh

export `gnome-keyring-daemon --start --daemonize`

[ "$(hostname)" = "bruch" ] && xrandr --output VGA2 --right-of VGA1 --auto

exec awesome
