# Salmefelt

https://guide.elm-lang.org/optimization/asset_size.html

```json
{
  "pure_getters": true,
  "keep_fargs": false,
  "unsafe_comps": true,
  "unsafe": true,
  "passes": 2,
  "pure_funcs": [
    "A2",
    "A3",
    "A4",
    "A5",
    "A6",
    "A7",
    "A8",
    "A9",
    "F2",
    "F3",
    "F4",
    "F5",
    "F6",
    "F7",
    "F8",
    "F9"
  ]
}
```

A fancy makefile / even a shell script might really do for building the app.
Lots of manual labour initially though.
Try out on random new project?
Additionally missing here are css transformations, moving everything necessary to the build folder the expected way and elm live doesn't support more than one proxy and external static file folders.
(and seemed to make my laptop hotter than expected while idling - not 100% sure it was elm-live at that time, might have been some other wild node processes)

```makefile
SHELL = /bin/sh
.SUFFIXES:
.SUFFIXES: .elm .js

MAIN_FILE = src/Main.elm
OUTPUT_FILE = build/elm.js
RUN_UGLIFY = npx uglify-js $(OUTPUT_FILE) --output=$(OUTPUT_FILE)
.PHONY: production dev test clean installDevDependencies installDependencies

UGLIFY =
	uglifyjs $(OUTPUT_FILE) \
		--compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters=true,keep_fargs=false,unsafe_comps=true,unsafe=true,passes=2' \
		--output=$(OUTPUT_FILE) \
		&& uglifyjs $(OUTPUT_FILE) --mangle --output=$(OUTPUT_FILE)

production:
	npx elm make \
		--optimize $(MAIN_FILE) \
		--output=$(OUTPUT_FILE) \
		&& echo "Uglifying output..." \
		&& $(UGLIFY)

dev:
	npx elm-live \
		$(MAIN_FILE) \
		--open \
		--port=3000 \
		--start-page=assets/index.dev.html \
		--proxyPrefix=/api \
		--proxyHost=http://localhost:8000 \
		-- --output=$(OUTPUT_FILE) --debug

test:
	npx elm-test

clean:
	rm -rf build
	rm -rf elm-stuff

installDependencies:
	npm install elm@"^0.19.x" --no-package-lock
	npm install elm-live@"^3.x.x" --no-package-lock
	npm install uglify-js@"^3.x.x" --no-package-lock
```
