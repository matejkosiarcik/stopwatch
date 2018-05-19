# shellcheck shell=sh
# helper script to test program's compatibility with different pythons

set -euf
cd "$(dirname "${0}")"

python 'tests.py'
command -v python2 >/dev/null 2>&1 && python2 'tests.py'
command -v python3 >/dev/null 2>&1 && python3 'tests.py'
command -v pypy >/dev/null 2>&1 && pypy 'tests.py'
command -v pypy3 >/dev/null 2>&1 && pypy3 'tests.py'
