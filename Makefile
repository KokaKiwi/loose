# Paths
NODE_MODULES	=	node_modules
BOWER_ROOT		=	bower_components
EXE_ROOT		=	$(NODE_MODULES)/.bin

JAVA			=	java
JADE			=	$(EXE_ROOT)/jade
TSC				=	$(EXE_ROOT)/tsc
RIOT			=	$(EXE_ROOT)/riot
MINIFY			=	$(EXE_ROOT)/minify
SCSS			=	$(EXE_ROOT)/scss-cli

# Variables
DEBUG			?=	0

TAG_SCRIPTS		=	loose.tag
GENERATED_JS	=	$(TAG_SCRIPTS:.tag=.js) main.js
ifeq ($(DEBUG),0)
JS_SCRIPTS		+=	$(BOWER_ROOT)/riot/riot.min.js
JS_SCRIPTS		+=	$(BOWER_ROOT)/random/lib/random.min.js
else
JS_SCRIPTS		+=	$(BOWER_ROOT)/riot/riot.js
JS_SCRIPTS		+=	$(BOWER_ROOT)/random/lib/random.js
endif
JS_SCRIPTS		+=	$(GENERATED_JS)
GENERATED_CSS	=	main.css
CSS_STYLES		+=	$(GENERATED_CSS)

# Flags
CLOSURE_FLAGS	=	--compilation_level=SIMPLE --language_in ECMASCRIPT5 --warning_level QUIET --externs extern.js
JADE_FLAGS		=	-p .
RIOT_FLAGS		=	-c --expr
TSC_FLAGS		=	-t ES5
SCSS_FLAGS		=	--include-path $(BOWER_ROOT)

# Phony rules
all: html
.PHONY: all

html: index.html
.PHONY: html

scripts: script.js
.PHONY: scripts

clean:
	rm -f index.html
	rm -f script.js $(GENERATED_JS)
	rm -f style.css $(GENERATED_CSS)
.PHONY: clean

install-deps:
	npm install
	bower install
.PHONY: install-deps

clean-deps:
	rm -rf $(NODE_MODULES) $(BOWER_ROOT)
.PHONY: clean-deps

# File rules
index.html: script.js style.css

script.js: $(JS_SCRIPTS) extern.js
ifeq ($(DEBUG),0)
	$(JAVA) -jar compiler.jar $(CLOSURE_FLAGS) $(JS_SCRIPTS) > $@
else
	cat $(JS_SCRIPTS) > $@
endif

style.css: $(CSS_STYLES)
ifeq ($(DEBUG),0)
	$(MINIFY) $^ > $@
else
	cat $^ > $@
endif

# Wildcard rules
%.html: %.jade
	$(JADE) $(JADE_FLAGS) < $< > $@

%.js: %.ts
	$(TSC) $(TSC_FLAGS) --out $@ $<

%.js: %.tag
	$(RIOT) $< $(RIOT_FLAGS)

%.css: %.scss
	$(SCSS) $(SCSS_FLAGS) $<
