. $HOME/.bashrc

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.usr" ] ; then
    PATH="$HOME/.usr/bin:$PATH"
fi

# set PATH so it includes cabal's bin if it exists
if [ -d "$HOME/.cabal" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi
