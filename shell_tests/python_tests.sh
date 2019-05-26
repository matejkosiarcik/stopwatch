#!/usr/bin/env bats

@test '"help" (using short argument)' {
  run python 'stopwatch/stopwatch.py' -h
  [ "${status}" -eq '0' ]
  [ "${output}" != '' ]

  stdout="$(mktemp)"
  stderr="$(mktemp)"
  python 'stopwatch/stopwatch.py' -h >"${stdout}" 2>"${stderr}"
  [ "$(cat "${stdout}")" != '' ]
  [ "$(cat "${stderr}")" == '' ]
  rm -f "${stdout}" "${stderr}"
}

@test '"help" (using long argument)' {
  run python 'stopwatch/stopwatch.py' --help
  [ "${status}" -eq '0' ]
  [ "${output}" != '' ]

  stdout="$(mktemp)"
  stderr="$(mktemp)"
  python 'stopwatch/stopwatch.py' --help >"${stdout}" 2>"${stderr}"
  [ "$(cat "${stdout}")" != '' ]
  [ "$(cat "${stderr}")" == '' ]
  rm -f "${stdout}" "${stderr}"
}

@test 'failing (using invalid short argument)' {
  run python 'stopwatch/stopwatch.py' -x
  [ "${status}" -ne '0' ]
  [ "${output}" != '' ]

  stdout="$(mktemp)"
  stderr="$(mktemp)"
  python 'stopwatch/stopwatch.py' -x >"${stdout}" 2>"${stderr}" || true
  [ "$(cat "${stdout}")" == '' ]
  [ "$(cat "${stderr}")" != '' ]
  rm -f "${stdout}" "${stderr}"
}

@test 'failing (using invalid long argument)' {
  run python 'stopwatch/stopwatch.py' --xyz
  [ "${status}" -ne '0' ]
  [ "${output}" != '' ]

  stdout="$(mktemp)"
  stderr="$(mktemp)"
  python 'stopwatch/stopwatch.py' --xyz >"${stdout}" 2>"${stderr}" || true
  [ "$(cat "${stdout}")" == '' ]
  [ "$(cat "${stderr}")" != '' ]
  rm -f "${stdout}" "${stderr}"
}
