#Make sure you're working on a virtual environmant


venv:
	python3 -m venv ./env

# Initializes virtual environment with basic requirements.
prod:
	source ./env/bin/activate; \
	pip install -r requirements.txt; \
	gunicorn --paste production.ini
	npm install --production

# Installs development dependencies.
dev:
	source ./env/bin/activate; \
	pip3 install -r requirements.txt; \
	pip3 install --upgrade pip setuptools; \
	yarn generate-lock-entry; \
	yarn; \
	python3 setup.py develop; \

# runs tests for your project
test:
	source ./env/bin/activate; \
	pytest; \

# Runs development server.
# This step depends on `make dev`, however dependency is excluded to speed up dev server startup.
run:
	source ./env/bin/activate; \

	webpack-dev-server --inline --hot & gunicorn --paste development.ini --reload

# Builds files for distribution which will be placed in /static/dist
build:
	yarn run build

# Cleans up folder by removing virtual environment, node modules and generated files.
clean:
	yarn clean; \
	rm -rf node_modules; \
	rm -rf pyramidVue/static/dist; \

