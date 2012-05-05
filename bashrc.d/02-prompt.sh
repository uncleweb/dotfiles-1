#!/bin/sh
#
# Copyright 2012 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Author: yesudeep@google.com (Yesudeep Mangalapilly)
#
# Based on:
# 1. https://github.com/thomasvs/bash-prompt-git/blob/master/git
# 2. http://jonmaddox.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
# 3. http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html


function is_submodule() {
  local git_dir parent_git module_name path strip
  # Find the root of this git repo, then check if its parent dir is also a repo
  git_dir="$(git rev-parse --show-toplevel)"
  parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"

  if [[ -n $parent_git ]]; then
    strip=$((${#parent_git} + 1))
    module_name=${git_dir:$strip}
    # List all the submodule paths for the parent repo
    while read path
    do
      if [[ "$path" != "$module_name" ]]; then continue; fi
      if [[ -d "$parent_git/$path" ]]; then
        echo $module_name
        return 0;
      fi
    done < <(cd $parent_git && git submodule --quiet foreach 'echo $path' 2> /dev/null)
  fi
  return 1
}


function parse_git_branch {
  git show > /dev/null 2>&1 || return
  P=

  SM=
  submodule=$(is_submodule)
  if [[ $? -eq 0 ]]; then
    SM="s:$submodule"
  fi
  P=$P${SM:+${P:+ }${SM}}

  BRANCH=
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ $? -eq 0 ]]; then
    BRANCH="b:${ref#refs/heads/}"
  fi
  P=$P${BRANCH:+${P:+ }${BRANCH}}


  DESC="d:"$(git describe 2> /dev/null) || DESC=""
  P=$P${DESC:+${P:+ }${DESC}}

  # https://github.com/blog/297-dirty-git-state-in-your-prompt
  DIRTY=
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]; then
    DIRTY="*"
  fi

  # STAT=
  # status=$(git status -s 2> /dev/null)
  # if [[ $? -eq 0 ]]; then
  #     STAT="$status"
  # fi

  echo "${DIRTY}git(${P}) "
}

# function hg_prompt_info {
#     hg prompt --angle-brackets "\
# < on <branch>>\
# < at <tags|, >>\
# <status|modified|unknown><update><
# patches: <patches|join( ? )>>" 2> /dev/null
# }

# function parse_mercurial_branch {
#   hg root > /dev/null 2>&1 || return
#   hg_prompt_info
# }

function hg_dirty() {
    hg status --no-color 2> /dev/null \
    | awk '$1 == "?" { print "?" } $1 != "?" { print "*" }' \
    | sort | uniq | head -c1
}

function parse_mercurial_branch {
  hg root > /dev/null 2>&1 || return
  BRANCH=
  ref=$(hg branch 2> /dev/null) #| awk '{print "hg(b:" $1 ")"}'
  if [[ $? -eq 0 ]]; then
    BRANCH="b:${ref}"
  fi
  P=$P${BRANCH:+${P:+ }${BRANCH}}

  DIRTY=$(hg_dirty)

  echo "${DIRTY}hg(${P})"
}

function show_git_status {
  #STAT=$(git diff --stat 2> /dev/null) || STAT=""
  status=$(git status -s 2> /dev/null)
  if [[ $? -eq 0 ]]; then
    echo "$status"
  fi
}

# function parse_git_branch {
#   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
# }

function escape() {
  echo "\[\033[$1\]"
}

# Formatting
format_bold_on=$(escape 1m)
format_bold_off=$(escape 22m)
format_blink_on=$(escape 5m)
format_blink_off=$(escape 25m)
format_reverse_on=$(escape 7m)
format_reverse_off=$(escape 27m)

# Colors
color_reset=$(escape 0m)

# Foreground colors
color_fg_default=$(escape 39m)
color_fg_black=$(escape 30m)
color_fg_red=$(escape 31m)
color_fg_green=$(escape 32m)
color_fg_brown=$(escape 33m)
color_fg_blue=$(escape 34m)
color_fg_purple=$(escape "35m")
color_fg_magenta=$(escape "1;35m")
color_fg_cyan=$(escape 36m)
color_fg_white=$(escape 37m)

# Background colors
color_bg_default=$(escape 49m)
color_bg_black=$(escape 40m)
color_bg_red=$(escape 41m)
color_bg_green=$(escape 42m)
color_bg_brown=$(escape 43m)
color_bg_blue=$(escape 44m)
color_bg_purple=$(escape 45m)
color_bg_magenta=$(escape "1;45m")
color_bg_cyan=$(escape 46m)
color_bg_white=$(escape 47m)

function proml {
  # local        BLUE="\[\033[0;34m\]"
  # local         RED="\[\033[0;31m\]"
  # local   LIGHT_RED="\[\033[1;31m\]"
  # local       GREEN="\[\033[0;32m\]"
  # local LIGHT_GREEN="\[\033[1;32m\]"
  # local       WHITE="\[\033[1;37m\]"
  # local  LIGHT_GRAY="\[\033[0;37m\]"

  # Color names:
  # base on http://pastie.org/154354
  # color_name='\[\033[ color_code m\]'
  #local color_fg_red='\[\033[01;31m\]'
  #local color_fg_forest='\[\033[00;32m\]'
  #local color_fg_green='\[\033[01;32m\]'
  #local color_fg_brown='\[\033[00;33m\]'
  #local color_fg_yellow='\[\033[01;33m\]'
  #local color_fg_navy='\[\033[00;34m\]'
  #local color_fg_blue='\[\033[01;34m\]'
  #local color_fg_purple='\[\033[00;35m\]'
  #local color_fg_magenta='\[\033[01;35m\]'
  #local color_fg_cadet='\[\033[00;36m\]'
  #local color_fg_cyan='\[\033[01;36m\]'
  #local color_fg_gray='\[\033[00;37m\]'
  #local color_fg_white='\[\033[01;37m\]'

  if [ `id -u` -eq 0 ]
  then
    # Root user.
    local color_fg_usr="${color_fg_red}"
    local dollar="\\#"
  else
    # Normal user.
    local color_fg_usr="${color_fg_green}"
    local dollar="\\$"
  fi

  case $TERM in
    xterm*)
      TITLEBAR='\[\033]0;\u@\h:\w\007\]'
      ;;
    *)
      TITLEBAR=""
      ;;
  esac

  PS1="
${TITLEBAR}${color_fg_green}\d \@ [\t]${color_reset} ${color_fg_red}\u${color_reset}@${color_fg_cyan}\H${color_reset}
${color_fg_blue}\w${color_reset}
${color_fg_purple}\$(parse_git_branch)\$(parse_mercurial_branch)${color_reset}${color_fg_usr}${dollar}${color_reset} "

  PS2='> '
  PS4='+ '
}
proml


export PS1

#http://superuser.com/questions/204003/make-os-x-terminal-commands-i-type-bold
#off="\[\033[m\]"
#trap 'echo -ne "${off}" > $(tty)' DEBUG
