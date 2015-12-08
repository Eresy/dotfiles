. $HOME/.bashrc

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.usr" ] ; then
    PATH="$HOME/.usr/bin:$PATH"
fi

#set vdpau driver
export VDPAU_DRIVER=nvidia
