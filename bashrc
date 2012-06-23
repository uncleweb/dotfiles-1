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


# Enable this line to switch on logging and debugging.
#_DEBUG="true"

if [[ "$_DEBUG" == "true" ]]; then
  function _log() {
    echo 1>&2 "$@"
  }
else
  function _log() {
    # Do nothing.
    echo -n
  }
fi


# Ensure we have UTF-8 and US English as our defaults.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# Google-specific definitions
CORP_GOOGLE_DOMAIN_HOSTNAME="corp.google.com"
CORP_GOOGLE_LAPPY_HOSTNAME="-glaptop"


# Author and maintainer.
REPORT_BUG_EMAIL="yesudeep@google.com"
AUTHOR_EMAIL="yesudeep@google.com"


# Detect essential system configuration.
HOSTNAME=`hostname`
WHOAMI=`whoami`


# Previous attempts at detecting the .dotfiles directory.
#DOTFILES_DIR=$(dirname "$(readlink -fn -- "$0")")
#DOTFILES_DIR=$(dirname -- "$0")
#DOTFILES_DIR=$HOME/.dotfiles


# Determine the directory this source file is in.
# From: http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ];
do
  SOURCE="$(readlink "$SOURCE")";
done

#DOTFILES_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd -P "$( dirname "$SOURCE" )" && pwd )"
export SHELLRC_DIR=$DOTFILES_DIR/bashrc.d


# Load the path environment.
# Note that this has to be loaded before anything else
# because other scripts depend on the availibility of the entire $PATH
# environment variable. See bashrc.d/os/darwin/00-init.sh for example.
if [ -f $HOME/.path_environment ]; then
  _log "Loading path environment from $HOME/.path_environment"
  source $HOME/.path_environment
fi


# Load OS-independent extension scripts.
# To disable a script, simply change its extension
# to anything other than `.sh`. To reorder a script,
# change its number prefix.
for f in $SHELLRC_DIR/*.sh
do
  _log "Loading $f"
  source $f
done


# Load OS-specific scripts.
# To disable a script, simply change its extension
# to anything other than `.sh`. To reorder a script,
# change its number prefix.
if [ -e $SHELLRC_DIR/os/$OSTYPE ]; then
  for f in $SHELLRC_DIR/os/$OSTYPE/*.sh
  do
    _log "Loading $f"
    source $f
  done
else
  echo "ERROR: Unknown \$OSTYPE: $OSTYPE."
  echo "Please report this \$OSTYPE to $REPORT_BUG_EMAIL."
fi


# Load hostname based overrides.
if [ -e $SHELLRC_DIR/hosts/$HOSTNAME ]; then
  for f in $SHELLRC_DIR/hosts/$HOSTNAME/*.sh
  do
    _log "Loading $f"
    source $f
  done
fi


# Load username based overrides.
if [ -e $SHELLRC_DIR/users/$WHOAMI ]; then
  for f in $SHELLRC_DIR/users/$WHOAMI/*.sh
  do
    _log "Loading $f"
    source $f
  done
fi


# Google-specific overrides.
case $HOSTNAME in
  *$CORP_GOOGLE_DOMAIN_HOSTNAME | *$CORP_GOOGLE_LAPPY_HOSTNAME)
    if [ -e $HOME/.$CORP_GOOGLE_DOMAIN_HOSTNAME/path_environment ]; then
      _log "Loading $HOME/.$CORP_GOOGLE_DOMAIN_HOSTNAME/path_environment"
      source $HOME/.$CORP_GOOGLE_DOMAIN_HOSTNAME/path_environment
    fi

    if [ -e $HOME/.$CORP_GOOGLE_DOMAIN_HOSTNAME/bashrc.d ]; then
      for f in $HOME/.$CORP_GOOGLE_DOMAIN_HOSTNAME/bashrc.d/*.sh
      do
        _log "Loading $f"
        source $f
      done
    else
      echo "WARNING: You do not have Google-specific shell configuration"
      echo "installed at $HOME/.$CORP_GOOGLE_DOMAIN."
    fi;;
esac


# Third-party

# A little bit of Emacs awesomeness for the terminal. I don't know
# how you live without this.
BASH_IDO=$DOTFILES_DIR/bashrc.d/third_party/bash-ido/bash-ido
if [ ! -f $BASH_IDO ]; then
  pushd $DOTFILES_DIR
  git submodule update --init --recursive
  popd
fi
source $BASH_IDO && _log "Loading $BASH_IDO"
