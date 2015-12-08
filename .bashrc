#
# ~/.bashrc
#
# Last Modified 2012/06/02


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#XTERM Auto transparency
#[ -n "$XTERM_VERSION" ] && transset-df 0.5 -a >/dev/null
#########################################
#Black      0;30 Dark Gray    1;30	#
#Blue       0;34 Light Blue   1;34	#
#Green      0;32 Light Green  1;32	#
#Cyan       0;36 Light Cyan   1;36	#
#Red        0;31 Light Red    1;31	#
#Purple     0;35 Light Purple 1;35	#
#Brown      0;33 Yellow       1;33	#
#Light Gray 0;37 White        1;37	#
#########################################

#Prompt formatting samples
#PS1='[\u@\h \W]\$ '
#export PS1="\u@\h:\W > "				 				#username@hostname >
#export PS1="[\t] \u@\h:\W > "    							#ora + username@hostname >
#export PS1="["$(acpi -b | sed -r 's/^[^,]+,//')" ] \u@\h:\W > "			#carica batteria
#export PS1="\[\033[1;31m\]\u@\h:\W > \[\033[0m\]"					#prompt colorato
#export PS1="\[\033[1;31m\]\u@\h:\W > \[\033[1;37m\] "					#prompt colorato e input colorato.
#export PS1="\\[\033[0;35m\](\j)\[\033[0m\]\[\033[1;31m\]\u@\h:\W > \[\033[0m\]"	#prompt colorato con i lavori gestiti dalla shell: \$? e \j

if [ "$TERM" = linux ]; then
#linux=tty
	PS1="\[\033[0;31m\]\u@\h:\W > \[\033[0m\]\[\033[1;37m\]"
	setterm -bfreq 0
else
	PS1="\\[\033[1;35m\](\j)\[\033[0m\]\[\033[1;31m\]\u@\h:\W > \[\033[0m\]"
fi

export HISTCONTROL="ignoreboth:erasedups"
#	erasedups
#		  --> erase all previous lines matching the current line from the history list before that line is saved.
# 	ignoredups
#		  --> don't put duplicate lines in the history. See bash(1) for more options
#	ignoreboth
# 		  --> ignore same sucessive entries.

#don't put this command in the history file
export HISTIGNORE="&:l[als]:ll[lar]:cd:cd..:cd[ ]*:cdl*:history:exit:[ ]*:ll[ ]*:lll[ ]*:df:date:xinit"

#record commands time
export HISTTIMEFORMAT="%h/%d/%Y - %H:%M:%S "
#export HISTTIMEFORMAT="%d/%m/%y - %H:%M:%S "	01/12/11
#export HISTTIMEFORMAT="%B/%d/%Y - %H:%M:%S "	mese esteso/giorno/anno

#remove history file dimension limitation and set the number of remembered command
unset HISTFILESIZE
export HISTSIZE="200000000"

#Syncs histories between terminals updating it at every prompt return
#shopt -s histappend
#PROMPT_COMMAND="history -n; history -a"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|st*)
    PROMPT_COMMAND='echo -ne "\033]0; ${PWD/$HOME/~}\007"'
    ;;                              #${USER}@${HOSTNAME}: 
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#if [ -f ~/.bash_aliases ]; then
#	. ~/.bash_aliases
#fi

# some aliases
alias qp='ps U $USER -f f'

alias ls='ls --color=auto'
alias ll='ls -lht'
alias la='ls -A'
alias lla='ls -lAht'
alias llr='ls -lAhtR'
alias lll='ls -lh'
alias l='ls'

alias cd..='cd ..'
alias cdd='cd'
alias cdh='cd ~/uni/LC1/Haskell/'
alias cdlc='cd ~/uni/LC1'
alias cdlp='cd ~/uni/LC1/LC1Project/'
alias vim='vim -p'
alias df='df -h'
alias texclean='rm -f *.aux *.log *.dvi *.out'

alias log='git log --graph --oneline --decorate --all'
#alias skype='xhost +local: && sudo -u skype skype'

alias lrsync='rsync -tvauh --no-checksum  --inplace --progress'

alias vifm='vifm -c only'
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#LS_COLOR impostazioni
eval `dircolors $HOME/.coloursrc`

#usare vim come editor
export EDITOR=vim
#-------->
#torify wget 
#http_proxy=http://127.0.0.1:8118/
#HTTP_PROXY=$http_proxy
#export http_proxy HTTP_PROXY

#export TEXINPUTS=`kpsepath tex`

#man() {
#	env \
#		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
#		LESS_TERMCAP_md=$(printf "\e[1;31m") \
#		LESS_TERMCAP_me=$(printf "\e[0m") \
#		LESS_TERMCAP_se=$(printf "\e[0m") \
#		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
#		LESS_TERMCAP_ue=$(printf "\e[0m") \
#		LESS_TERMCAP_us=$(printf "\e[1;32m") \
#			man "$@"
#}


# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.                                                                                                                                                                                     
function ghc-pkg-clean() {
    for p in `ghc-pkg check $* 2>&1  | grep problems | awk '{print $6}' | sed -e 's/:$//'`
    do
        echo unregistering $p; ghc-pkg $* unregister $p
    done
}

# remove all installed GHC/cabal packages, leaving ~/.cabal binaries and docs in place.                                                                                          # When all else fails, use this to get out of dependency hell and start over.                                                                                                    
function ghc-pkg-reset() {
    read -p 'erasing all your user ghc and cabal packages - are you sure (y/n) ? ' ans
    test x$ans == xy && ( \
        echo 'erasing directories under ~/.ghc'; rm -rf `find ~/.ghc -maxdepth 1 -type d`; \
        echo 'erasing ~/.cabal/lib'; rm -rf ~/.cabal/lib; \
        # echo 'erasing ~/.cabal/packages'; rm -rf ~/.cabal/packages; \                                                                                                                                                                     
        # echo 'erasing ~/.cabal/share'; rm -rf ~/.cabal/share; \                                                                                                                                                                           
        )
}
alias cabalupgrades="cabal list --installed  | egrep -iv '(synopsis|homepage|license)'"

#gibo autocomplete, here for autocompleting despite gibo being in ~/.usr
_gibo()
{
    local cur opts
    opts=$( find $HOME/.gitignore-boilerplates -name "*.gitignore" -exec basename \{\} .gitignore \; )
    cur="${COMP_WORDS[COMP_CWORD]}"

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}
complete -F _gibo gibo
