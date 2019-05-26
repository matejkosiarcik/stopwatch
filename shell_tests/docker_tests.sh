#!/usr/bin/env bats

@test '"help" (using short argument)' {
  run docker run -it 'stopwatch:dev' -h
  [ "${status}" -eq '0' ]
  [ "${output}" != '' ]
}

@test '"help" (using long argument)' {
  run docker run -it 'stopwatch:dev' --help
  [ "${status}" -eq '0' ]
  [ "${output}" != '' ]
}

@test 'failing (using invalid short argument)' {
  run docker run -it 'stopwatch:dev' -x
  [ "${status}" -ne '0' ]
  [ "${output}" != '' ]
}

@test 'failing (using invalid long argument)' {
  run docker run -it 'stopwatch:dev' --xyz
  [ "${status}" -ne '0' ]
  [ "${output}" != '' ]
}
