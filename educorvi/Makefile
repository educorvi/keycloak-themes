.PHONY: all
bootstrap = login/resources/node_modules/bootstrap/README.md

all: build_theme

dist: build_theme
	rm -rf dist
	mkdir -p dist/login/resources
	cp login/theme.properties dist/login
	cp -R login/resources/img dist/login/resources

check_dependency_%:
	@echo -n "Checking dependency $*... "
	@command -v $* >/dev/null 2>&1 && echo "found" || (echo "\nNo $* in PATH, please install it" && exit 1)


build_theme:
