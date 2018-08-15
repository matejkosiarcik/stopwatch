MAKEFLAGS += --warn-undefined-variables
FORCE:

test: FORCE
	if command -v py.test >'/dev/null' 2>&1; then \
		py.test tests; \
	elif command -v pytest >'/dev/null' 2>&1; then \
		pytest tests; \
	else \
		exit 1; \
	fi
