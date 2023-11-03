.PHONY: all
scss_src = $(shell find . -type f -name "*.scss")
bootstrap = login/resources/theme/node_modules/bootstrap/README.md
ef_theme = login/resources/theme/ef_theme-fiverules/theme.scss

all: build_theme

dist: build_theme
	rm -rf dist
	mkdir -p dist/login/resources/theme
	cp login/theme.properties dist/login
	cp -R login/resources/img dist/login/resources
	cp -R login/resources/theme/theme.css dist/login/resources/theme/theme.css

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

css-clean:
	rm -f login/resources/theme/theme.css
