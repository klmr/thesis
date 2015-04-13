fullpath := $(shell pwd -P)
LATEXMK := latexmk -pdf -r ${fullpath}/.latexmkrc
BIN := ./scripts

target := thesis
references := references.bib
includes := $(shell ls *.{tex,cls}) ${references}
bib_sources := $(shell cat bib_sources.conf)

# The thesis itself.

.PHONY: ${target}
${target}: ${target}.pdf

${target}.pdf: ${includes}

rna-seq-standalone.pdf: rna-seq-example.tex

%.pdf: %.tex
	cd $$(dirname $@); ${LATEXMK} $$(basename $<)

# PGF figures

# FIXME: This isn’t perfect, because it needs to be triggered manually.
.PHONY: figures
figures: ${$(shell cat ${target}.figlist):%=%.md5} figures.make cache
	${MAKE} -f figures.make

figures.make: ${target}.makefile
	sed -e 's/pdflatex/xelatex/g' -e 's/\^\^I/	/g' $< > $@

cache:
	mkdir -p cache

# Interactive preview rule; not really a target per se, and builds the thesis.

.PHONY: preview
preview:
	${LATEXMK} -pvc ${target}

# Reference

${references}: ${bib_sources}
	./scripts/import-paperpile ${bib_sources} > $@

# Targets generated from R markdown (knitr) documents

%.md: %.rmd
	${BIN}/knit $< $@

%.html: %.rmd
	${BIN}/knit $< $@

%.tex: %.md
	pandoc --no-highlight --to latex $< | ./scripts/fix-pandoc > $@

.SECONDARY: rna-seq-example.md

# Cleanup

.PHONY: clean
clean:
	${RM} $(filter-out %.tex %.cls %.pdf,$(shell ls ${target}.*))
	${RM} ${target}-blx.bib
	${RM} texput.log
	${RM} xelatex*.fls
	${RM} -r $(shell biber --cache)
	${RM} cache/*
	${RM} figures.make
	${RM} $(patsubst %.rmd,%.md,$(wildcard *.rmd))

.PHONY: cleanall
cleanall: clean
	${RM} ${target}.pdf
	${RM} ${references}
	${RM} $(patsubst %.rmd,%.html,$(wildcard *.rmd))
