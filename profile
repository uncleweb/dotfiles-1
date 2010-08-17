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


# Path environment variable extensions.

