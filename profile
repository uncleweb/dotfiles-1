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


# Ensure we have UTF-8 and US English as our defaults.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -e $HOME/.bashrc.d ]; then
    # Check if we have the bashrc.d directory symlinked.
    BASHRC_DIR=$HOME/.bashrc.d
elif [ -e $HOME/dotfiles/bashrc.d ]; then
    # Attempt to use the dotfiles bashrc.d directory.
    BASHRC_DIR=$HOME/dotfiles/bashrc.d
fi

# Load OS-independent extension scripts.
# To disable a script, simply change its extension
# to anything other than `.sh`. To reorder a script,
# change its number prefix.
if [ -e $BASHRC_DIR ]; then
    for f in $BASHRC_DIR/*.sh
    do
        echo "Loading $f"
        . $f
    done
fi

# Load OS-specific scripts.
# To disable a script, simply change its extension
# to anything other than `.sh`. To reorder a script,
# change its number prefix.
if [[ $OSTYPE == "linux-gnu" ]]; then
    # Operating system is Linux so load Linux-specific scripts.
    if [ -e $BASHRC_DIR/os/linux ]; then
        for f in $BASHRC_DIR/os/linux/*.sh
        do
            echo "Loading $f"
            . $f
        done
    fi
elif [[ $OSTYPE == "darwin11" ]]; then
    # Operating system is Mac OS X so load darwin-specific scripts.
    if [ -e $BASHRC_DIR/os/darwin ]; then
        for f in $BASHRC_DIR/os/darwin/*.sh
        do
            echo "Loading $f"
            . $f
        done
    fi
fi

# Load hostname based overrides
if [ -e $BASHRC_DIR/hosts/`hostname`.sh ]; then
    echo "Loading $BASHRC_DIR/hosts/`hostname`.sh"
    . $BASHRC_DIR/hosts/`hostname`.sh
fi

# Load username based overrides
if [ -e $BASHRC_DIR/users/`whoami`.sh ]; then
    echo "Loading $BASHRC_DIR/users/`whoami`.sh"
    . $BASHRC_DIR/users/`whoami`.sh
fi

# Load the path environment.
if [ -f $HOME/.path_environment ]; then
    echo "Loading path environment from $HOME/.path_environment"
    . $HOME/.path_environment
fi
