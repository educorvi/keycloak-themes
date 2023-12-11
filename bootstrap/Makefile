.PHONY: all
bootstrap = login/resources/node_modules/bootstrap/README.md

all: build_theme

dist: build_theme
	rm -rf dist
	mkdir -p dist/login/resources/node_modules/bootstrap/
	mkdir -p dist/login/resources/js
	cp login/theme.properties dist/login
	cp login/*.ftl dist/login
	cp -R login/resources/node_modules/bootstrap/dist dist/login/resources/node_modules/bootstrap
	cp -R login/resources/js dist/login/resources

check_dependency_%:
	@echo -n "Checking dependency $*... "
	@command -v $* >/dev/null 2>&1 && echo "found" || (echo "\nNo $* in PATH, please install it" && exit 1)


build_theme: check_dependency_npm $(bootstrap)

$(bootstrap):
	cd login/resources && npm install
