src := $(wildcard src/*.md)
img := $(wildcard img/*.png)
target := $(addprefix build/, $(addsuffix .html, $(basename $(notdir $(src)))))
imgtarget := $(addprefix build/img/, $(notdir $(img)))

pflags := --from=markdown+east_asian_line_breaks+emoji
pflags += --to=html5
pflags += --standalone
pflags += --katex
# use --katex-css + katex cli instead (waiting on KaTeX version bump)
pflags += --strip-comments
pflags += -V header-includes='<style>$(shell cat ./css/normalize.css ./css/style.css)</style>'
pflags += --lua-filter=./filters/task-list.lua

#cpflags := -V include-after='<a href="./index.html">一覧</a>'
#cpflags += -V include-after='<script>document.addEventListener("DOMContentLoaded", () => twemoji.parse(document.body, { folder: "svg", ext: ".svg" }));</script>'
#cpflags := -V include-after='<script>document.addEventListener("DOMContentLoaded", () => twemoji.parse(document.body, { folder: "svg", ext: ".svg" }));</script>'
#cpflags += -V include-after='<script src="//twemoji.maxcdn.com/2/twemoji.min.js?2.5" async></script>'
cpflags := -V include-after='<script src="https://utteranc.es/client.js" repo="mt-caret/papers" issue-term="title" theme="github-light" crossorigin="anonymous" async></script>'

build/img/%.png: img/%.png
	@mkdir -p build/img
	@echo "$< -> $@"
	@optipng -o2 -clobber $< -out $@

build/%.html: src/%.md
	@mkdir -p build
	@echo "$< -> $@"
	@pandoc $(pflags) $(cpflags) -V include-after='$(shell ./navigation.sh $<)' $< --output=$@

all: $(target) $(imgtarget) build/index.html

build/index.html: $(src)
	@mkdir -p build
	@echo "./index.sh -> $@"
	@./index.sh | pandoc $(pflags) --output=$@

.PHONY: clean
clean:
	rm -rf build/*

.PHONY: new
new:
	./new.sh

.PHONY: watch
watch: all
	@while sleep 1; do ls src/*.md | entr -cdrs "make all && serve ./build/"; done

.PHONY: deploy
deploy: all
	./deploy.sh

