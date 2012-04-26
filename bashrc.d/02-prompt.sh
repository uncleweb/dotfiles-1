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

    echo "(${P}) "
}

# function parse_git_branch {
#   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
# }

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[$RED\u@\h:\w$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\$ "
PS2='> '
PS4='+ '
}
proml
