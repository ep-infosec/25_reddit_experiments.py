SOURCE_ROOT := reddit_experiments/ reddit_decider/
PYTHON_SOURCE = $(shell find $(SOURCE_ROOT) tests/ setup.py -name '*.py')
REORDER_PYTHON_IMPORTS := reorder-python-imports --py3-plus --separate-from-import --separate-relative
PYTHON_VERSION ?= 3.9

.PHONY: fmt
fmt:
	$(REORDER_PYTHON_IMPORTS) --exit-zero-even-if-changed $(PYTHON_SOURCE)
	black $(PYTHON_SOURCE)


.PHONY: lint
lint:
	$(REORDER_PYTHON_IMPORTS) --diff-only $(PYTHON_SOURCE)
	black --diff --check $(PYTHON_SOURCE)
	flake8 $(SOURCE_ROOT)
	mypy $(SOURCE_ROOT) --python-version $(PYTHON_VERSION)

.PHONY: test
test:
	python -m pytest -v tests/


.PHONY: docs
docs:
	sphinx-build -M html docs/ build/
