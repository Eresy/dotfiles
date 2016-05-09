#!/bin/sh

#attiva gestione energetica schermo
	xset +dpms
#xset dpms standby suspend off/on

#valori in secondi->inattività prima che attivi una modalità, se =0 disabilitata
#
	xset dpms 0 0 600	

#configuration parameters for X client applications
#[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# set a cursor for xmonad desktop
xsetroot -cursor_name left_ptr

#imposto sfondo
#	display -window root "$HOME/.my_background/tux.jpg"
#	display -window root "$HOME/.my_background/2010.jpg"
#	display -window root "$HOME/.my_background/linux_file_structure.jpg"
#	feh --bg-center "$HOME/.usr/my_background/HAL.jpg"
#	feh --bg-center "$HOME/.usr/my_background/488711main_LagoonClose_hst_full.jg"
#	feh  --image-bg black --bg-max '/home/hal/.usr/my_background/466889main_Triton1_full.jpg' 
#feh  --image-bg black --bg-max '/home/hal/.usr/my_background/716720main_hubble_new_year_full_full.jpg' 

sh ~/.fehbg &

#alternativa
#while true; do
# Background.sh

#Some fonts like terminus are installed in /usr/share/fonts/local, which is not added to the font path by default. By adding the following lines to ~/.xinitrc
#if [ -f /usr/share/fonts/local ]; then
#	xset +fp /usr/share/fonts/local
#	xset fp rehash
#fi
#Multimedia Keys
#if [ -f $HOME/.Xmodmap ]; then
#	/usr/bin/xmodmap $HOME/.Xmodmap
#fi

#eval $(gpg-agent --daemon)

##pulseaudio
##/usr/bin/start-pulseaudio-x11 &

# bind key demone
#xbindkeys

#udiskie &

setxkbmap it

numlockx &


#dwmstatus &
#exec dwm > .xerrors 2>&1
exec xmonad > .xerrors 2>&1
