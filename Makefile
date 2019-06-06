# This Makefile does not contain any build steps
# It only groups scripts to use in project

MAKEFLAGS += --warn-undefined-variables
FORCE:

bootstrap: FORCE
	pip install -r 'requirements-dev.txt'

test: unit_test
	# TODO: add integration_test, docker_test, install_test

unit_test: FORCE
	python -m pytest 'tests'

integration_test: FORCE
	bats 'shell_tests/python_tests.sh'

docker_test: FORCE
	docker build '.' --tag 'stopwatch:dev'
	bats 'shell_tests/docker_tests.sh'

install_test: FORCE
	printf "Don\'t run this on system wide python/pip\n" >&2
	python -m pip install '.'
	bats 'shell_tests/system_tests.sh'
