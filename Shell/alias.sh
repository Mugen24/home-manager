#.1 -> .10
blight () {
	xrandr --output DP-1 --brightness $1 2>/dev/null
	xrandr --output DP-2 --brightness $1 2>/dev/null
	xrandr --output HDMI-1 --brightness $1 2>/dev/null
	xrandr --output HDMI-2 --brightness $1 2>/dev/null
	xrandr --output HDMI-1-3 --brightness $1 2>/dev/null
	xrandr --output DP-1-3 --brightness $1 2>/dev/null
	xrandr --output DP-1-4 --brightness $1 2>/dev/null
	xrandr --output DP-1-5 --brightness $1 2>/dev/null
}
