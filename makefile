.POSIX:
.PHONY: docs, all, clean, package, test
.SUFFIXES:
.SUFFIXES: .typ .svg .pdf
.typ.svg:
	typst compile --root . $< $@
.typ.pdf:
	typst compile --root . $< $@

convenient-karnaughs-dir = $(packages-dir)/packages/preview/convenient-karnaughs
version-dir = $(convenient-karnaughs-dir)/$(version)

docs/example-1-standalone.svg: docs/*.typ src/*/*.typ
docs/example-2-standalong.svg: docs/*.typ src/*/*.typ
docs/manual.pdf: docs/*.typ src/*/*.typ
docs: docs/example-1-standalone.svg docs/example-2-standalone.svg docs/manual.pdf
all: docs
clean:
	rm -rf docs/*.svg docs/*.pdf
package: docs
	[ -n "$(packages-dir)" ]
	[ -n "$(version)" ]
	mkdir -p "$(convenient-karnaughs-dir)"
	mkdir "$(version-dir)" # fails if version directory already exists
	cp -R LICENSE typst.toml README.md src "$(version-dir)"
	mkdir "$(version-dir)/docs" # fails if version directory already exists
	cp -R  docs/*.svg docs/*.pdf "$(version-dir)/docs"
