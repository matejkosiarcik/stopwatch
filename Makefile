# This Makefile does not contain any build steps
# It only groups scripts to use in project

MAKEFLAGS += --warn-undefined-variables
FORCE:

bootstrap: FORCE
	python -m pip install pytest

update: FORCE
	python -m pip install --upgrade pytest

test: FORCE
	python -m pytest 'tests'

install: FORCE
	pip install '.'
