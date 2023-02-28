#!/bin/bash

PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.nix-profile/bin"

win=$(yabai -m query --windows --window last | jq '.id')

while : ; do
    yabai -m window $win --swap prev &> /dev/null
    if [[ $? -eq 1 ]]; then
        break
    fi
done
