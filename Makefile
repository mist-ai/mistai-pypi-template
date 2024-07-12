# Helper function to export variables from a .env file
define load_env
    if [ -f $(1) ]; then export $$(cat $(1) | xargs); fi;
endef

.PHONY: init build publish publish-force

init:
	python3 -m venv venv
	@bash -c "source venv/bin/activate"
	pip install  --no-cache-dir  -r requirements.txt
	rm -rf dist mistai_hello.egg-info

build: init
	python3 -m build

publish: build
	$(call load_env,.env)
	TWINE_USERNAME=$(TWINE_USERNAME) TWINE_PASSWORD=$(PYPI_TOKEN) twine upload dist/*