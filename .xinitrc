#!/bin/sh

setxkbmap it

sh ~/.fehbg &

numlockx &

dwmstatus &
exec dwm > ~/.dwm.log 2>&1


#exec xmonad
