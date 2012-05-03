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

# Reverses the mouse scrolling on Linux to behave like Mac OS X natural
# scrolling.
# if [ ! -e $HOME/.natural_scrolling_enabled ]; then
#   xmodmap -e "pointer = 1 2 3 5 4 6 7 8 9 10 11 12" && touch $HOME/.natural_scrolling_enabled
# fi

xmodmap -e "pointer = 1 2 3 5 4 6 7 8 9 10 11 12" 2>&1 /dev/null
