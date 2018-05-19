# shellcheck shell=sh
# script to install program to user's PATH

set -euf
cd "$(dirname "${0}")"

[ -d "${HOME}/bin" ] || mkdir "${HOME}/bin"
target="${HOME}/bin/stopwatch"

printf '#!/usr/bin/env python\n' >"${target}"
cat 'main.py' >>"${target}"
chmod a+x "${target}"
