# Colors for the bash prompt based on operating system.
if [[ $OSTYPE == "linux-gnu" ]]; then
#    PS1="[\t][\u@\h:\w]\$ "
    alias ls="ls --color"
    export LS_COLORS="ln=1;31;44:"
elif [[ $OSTYPE == "darwin10.0" ]]; then
#    PS1="[\t][\u@\h:\w]\$ "
    export CLICOLOR=1
    export LSCOLORS exfxcxdxbxegebabagacad

    alias md5='md5 -r'
    alias md5sum='md5 -5'

fi

# Color names:
# base on http://pastie.org/154354
# color_name='\[\033[ color_code m\]'
rgb_restore='\[\033[00m\]'
rgb_black='\[\033[00;30m\]'
rgb_firebrick='\[\033[00;31m\]'
rgb_red='\[\033[01;31m\]'
rgb_forest='\[\033[00;32m\]'
rgb_green='\[\033[01;32m\]'
rgb_brown='\[\033[00;33m\]'
rgb_yellow='\[\033[01;33m\]'
rgb_navy='\[\033[00;34m\]'
rgb_blue='\[\033[01;34m\]'
rgb_purple='\[\033[00;35m\]'
rgb_magenta='\[\033[01;35m\]'
rgb_cadet='\[\033[00;36m\]'
rgb_cyan='\[\033[01;36m\]'
rgb_gray='\[\033[00;37m\]'
rgb_white='\[\033[01;37m\]'

rgb_std="${rgb_white}"

if [ `id -u` -eq 0 ]
then
    rgb_usr="${rgb_red}"
else
    rgb_usr="${rgb_forest}"
fi

# Different titlebar info depending on $TERM.
case $TERM in
    xterm*|rxvt*)
        TITLEBAR='\[\033]0;\u@\h \w\007\]'
        ;;
    emacs*)
        TITLEBAR=''
        ;;
    *)
        TITLEBAR="\u@\h \w"
        ;;
esac

# http://www.linuxselfhelp.com/howtos/Bash-Prompt/Bash-Prompt-HOWTO-2.html
# See the bash manpage.
# Different prompt depending on $TERM.
case $TERM in
    xterm*|rxvt*|emacs*)
        [ -n "$PS1" ] && PS1=\
"
${TITLEBAR}${rgb_forest}\d \@${rgb_restore} ${rgb_firebrick}\u${rgb_restore}@${rgb_cadet}\H
${rgb_firebrick}\w
${rgb_usr}\$${rgb_restore} "
        ;;

    *)
        [ -n "$PS1" ] && PS1="${TITLEBAR}\D{%Y-%m-%d} \t !\! \u@\h
\w
\$ "
        ;;
esac;

# Clean up
unset   rgb_restore   \
        rgb_black     \
        rgb_firebrick \
        rgb_red       \
        rgb_forest    \
        rgb_green     \
        rgb_brown     \
        rgb_yellow    \
        rgb_navy      \
        rgb_blue      \
        rgb_purple    \
        rgb_magenta   \
        rgb_cadet     \
        rgb_cyan      \
        rgb_gray      \
        rgb_white     \
        rgb_std       \
        rgb_usr


# Homebrew for Mac OS X.
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# MacPorts for Mac OS X.
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if [ -f $HOME/.path_environment ]; then
    . $HOME/.path_environment
fi


# GNUPG configuration
# Script for ensuring only one instance of gpg-agent is running
# and if there is not one, start an instance of gpg-agent.
#if test -f $HOME/.gpg-agent-info && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
#	GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
#	SSH_AUTH_SOCK=`cat $HOME/.ssh-auth-sock`
#	SSH_AGENT_PID=`cat $HOME/.ssh-agent-pid`
#	export GPG_AGENT_INFO SSH_AUTH_SOCK SSH_AGENT_PID
#else
#	eval `gpg-agent --daemon`
#	echo $GPG_AGENT_INFO >$HOME/.gpg-agent-info
#	echo $SSH_AUTH_SOCK > $HOME/.ssh-auth-sock
#	echo $SSH_AGENT_PID > $HOME/.ssh-agent-pid
#fi
# Imperative that this environment variable always reflects the output
# of the tty command.
#GPG_TTY=`tty`
#export GPG_TTY

# END GNUPG configuration


# Aliases
alias diffmate='git diff | mate'

# Path environment variable extensions.
appengine_bin=$HOME/Applications/google_appengine
python_bin=/usr/local/Cellar/python/2.7.1/bin:/usr/local/bin:/usr/local/sbin
ruby_bin=/usr/local/Cellar/ruby/1.9.2-p136/bin:/usr/local/Cellar/ruby/1.9.2-p180/bin
node_bin=$HOME/.node_libraries/uglify-js/bin
go_bin=$HOME/Applications/go/bin
pypy_bin=$HOME/Applications/pypy/bin
emacs_bin=$HOME/.emacs.d/bin
base_bin=/usr/local/bin:/usr/local/sbin
python3_bin=/usr/local/Cellar/python3/3.2/bin
home_bin=$HOME/Applications/bin

export PATH=$home_bin:$python_bin:$python3_bin:$ruby_bin:$node_bin:$go_bin:$pypy_bin:$emacs_bin:$appengine_bin:$base_bin:$PATH

ulimit -n 10000


