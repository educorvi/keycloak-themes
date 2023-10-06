.PHONY: all
scss_src = $(wildcard **/*.scss)
bootstrap = login/resources/theme/node_modules/bootstrap/README.md
ef_theme = login/resources/theme/ef_theme-fiverules/theme.scss

all: build_theme

check_dependency_%:
	@echo -n "Checking dependency $*... "
	@command -v $* >/dev/null 2>&1 && echo "found" || (echo "\nNo $* in PATH, please install it" && exit 1)


build_theme: check_dependency_npm login/resources/theme/theme.css

$(bootstrap):
	cd login/resources/theme && npm install

$(ef_theme):
	git submodule update --init --recursive

login/resources/theme/theme.css: $(scss_src) $(bootstrap) $(ef_theme)
	cd login/resources/theme && npm run build
