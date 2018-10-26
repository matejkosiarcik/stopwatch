# This Makefile does not contain any build steps
# It only groups scripts to use in project

MAKEFLAGS += --warn-undefined-variables
FORCE:

bootstrap: FORCE
	pip install pytest

update: FORCE
	pip install --upgrade pytest

test: FORCE
	if command -v py.test >'/dev/null' 2>&1; then \
		py.test 'tests'; \
	elif command -v pytest >'/dev/null' 2>&1; then \
		pytest 'tests'; \
	else \
		exit 1; \
	fi

install: FORCE
	pip install '.'
