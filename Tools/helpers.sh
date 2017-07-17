#!/bin/sh
#
# helpers.sh
# Copyright © 2017 Matej Kosiarcik. All rights reserved.
# This file contains helper functions for tools
#

# this removes excessive whitespace
# accepts single argument of file to format
strip() {
    printf "%s\n" "$(cat -s "${1}")" >"${1}"                   # strip multiple empty lines and trailing newlines
    printf "%s\n" "$(sed 's~[[:space:]]*$~~' <"${1}")" >"${1}" # remove trailing whitespace
}

# searches for passed command
# returns 0 if command was found, non-0 otherwise
# accepts single argument of command to look up
exists() {
    command -v "${1}" >/dev/null 2>&1
}

# checks if given tool exists
# print message if not
# accepts single argument of command to look up
check() (
    exists "${1}"
    doesExists="${?}"
    if [ ! "${doesExists}" -eq "0" ]; then
        printf "%s\n" "warning: ${1} not found. (tool_not_found)"
    fi
    return "${doesExists}"
)
