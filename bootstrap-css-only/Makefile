.PHONY: all, dist
bootstrap = login/resources/node_modules/bootstrap/README.md

all: build_theme

dist: build_theme
	rm -rf dist
	mkdir -p dist/login/resources/node_modules/bootstrap/
	mkdir -p dist/login/resources/js
	mkdir -p dist/login/resources/css
	cp login/theme.properties dist/login
	cp -R login/resources/node_modules/bootstrap/dist dist/login/resources/node_modules/bootstrap
	#cp -R login/resources/js dist/login/resources
	cp -R login/resources/css/* dist/login/resources/css

login/resources/css/bootstrap.min.css: $(bootstrap) login/resources/css/bootstrap.scss
	cd login/resources && npm install && npm run build

check_dependency_%:
	@echo -n "Checking dependency $*... "
	@command -v $* >/dev/null 2>&1 && echo "found" || (echo "\nNo $* in PATH, please install it" && exit 1)


build_theme: check_dependency_npm login/resources/css/bootstrap.min.css

$(bootstrap):
	cd login/resources && npm install
