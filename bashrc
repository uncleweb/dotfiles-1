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

# Basic configuration.
HOSTNAME=`hostname`
WHOAMI=`whoami`
CORP_GOOGLE_DOMAIN_HOSTNAME="corp.google.com"
CORP_GOOGLE_LAPPY_HOSTNAME="-glaptop"
REPORT_BUG_EMAIL="yesudeep@google.com"

#TOP_DIR=$(dirname "$(readlink -fn -- "$0")")
#TOP_DIR=$(dirname -- "$0")
#TOP_DIR=$HOME/.dotfiles

# Determine the directory this source file is in.
# From: http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ];
do
  SOURCE="$(readlink "$SOURCE")";
done
#TOP_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
TOP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd -P "$( dirname "$SOURCE" )" && pwd )"

# Load the configuration for bash.
SHELLRC_DIR=$TOP_DIR/bashrc.d

# Load the path environment.
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
  echo "ERROR: Unknown \$OSTYPE: $OSTYPE. Please report this \$OSTYPE to $REPORT_BUG_EMAIL."
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
    if [ -e $HOME/.$CORP_GOOGLE_DOMAIN/bashrc.d ]; then
      for f in $HOME/.$CORP_GOOGLE_DOMAIN/bashrc.d/*.sh
      do
        _log "Loading $f"
        source $f
      done
    else
      echo "WARNING: You do not have Google-specific shell configuration"
      echo "installed at $HOME/.$CORP_GOOGLE_DOMAIN."
    fi;;
esac
