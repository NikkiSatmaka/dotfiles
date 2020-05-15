#
# ~/.bash_profile
#

for File in "$HOME"/.config/sh/*; do
	. "$File"
done

# Start graphical server on tty1 if not already running.
if command -v startx > /dev/null 2>&1; then
	[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx
fi

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ${XDG_CONFIG_HOME:-$HOME/.config}/keymaps/ttymaps.kmap 2>/dev/null
