.RECIPEPREFIX = >

BIB_COMPILER = bibtex
TEX_COMPILER = pdflatex
PY_COMPILER  = python3

SUBJECT := calculus
WEEK    := W1
MODE    := pure

.PHONY: all pure scripted clean

all: $(MODE)

create:
> @echo "Creating homework for $(SUBJECT), $(WEEK)"
> @if [ ! -d "$(SUBJECT)/$(WEEK)/" ]; then \
> 	echo "Creating directory structure..."; \
>	mkdir -p "$(SUBJECT)/$(WEEK)/"; \
> 	cp "templates/$(SUBJECT).tex" "$(SUBJECT)/$(WEEK)/main.tex"; \
> else \
> 	echo "Already exists!"; \
> fi

pure:
> $(MAKE) build_pure SUBJECT=$(SUBJECT) WEEK=$(WEEK)

scripted:
> $(MAKE) build_scripted SUBJECT=$(SUBJECT) WEEK=$(WEEK)

build_scripted: build_python build_pure

build_pure:
> @echo "Building LaTeX for $(SUBJECT), $(WEEK)"
> mkdir -p build/$(SUBJECT)/$(WEEK)/
> $(TEX_COMPILER) -output-directory=build/$(SUBJECT)/$(WEEK)/ $(SUBJECT)/$(WEEK)/main.tex

build_python:
> @echo "Building Python for $(SUBJECT), $(WEEK)"
> mkdir -p build/$(SUBJECT)/$(WEEK)/img/
> $(PY_COMPILER) $(SUBJECT)/$(WEEK)/scripts/main.py

clean:
> @echo "Cleaning up build files..."
> rm -rf build/
