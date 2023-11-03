.PHONY: all
bootstrap = login/resources/node_modules/bootstrap/README.md

all: build_theme

check_dependency_%:
	@echo -n "Checking dependency $*... "
	@command -v $* >/dev/null 2>&1 && echo "found" || (echo "\nNo $* in PATH, please install it" && exit 1)


build_theme: check_dependency_npm $(bootstrap)

$(bootstrap):
	cd login/resources && npm install
