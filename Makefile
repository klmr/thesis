fullpath := $(shell pwd -P)
LATEXMK := latexmk -pdf -dvi- -ps- -r ${fullpath}/.latexmkrc

target := thesis
references := references.bib
includes := $(shell ls *.{tex,cls}) ${references}
bib_sources := $(shell cat bib_sources.conf)

.PHONY: ${target}
${target}: ${target}.pdf

${target}.pdf: ${includes}

%.pdf: %.tex
	cd $$(dirname $@); ${LATEXMK} $$(basename $<)

# FIXME: This isn’t perfect, because it needs to be triggered manually.
.PHONY: figures
figures: ${$(shell cat ${target}.figlist):%=%.md5} figures.make cache
	${MAKE} -f figures.make

figures.make: ${target}.makefile
	sed -e 's/pdflatex/xelatex/g' -e 's/\^\^I/	/g' $< > $@

cache:
	mkdir -p cache

.PHONY: preview
preview:
	${LATEXMK} -pvc ${target}

${references}: ${bib_sources}
	./scripts/import-paperpile ${bib_sources} > $@

.PHONY: cleancache
cleancache:
	${RM} -r $(shell biber --cache)
	${RM} cache/*

.PHONY: clean
clean: cleancache
	${RM} $(filter-out %.tex %.cls %.pdf,$(shell ls ${target}.*))
	${RM} ${target}-blx.bib
	${RM} texput.log
	${RM} xelatex*.fls
	${RM} figures.make

.PHONY: cleanall
cleanall: clean
	${RM} ${target}.pdf
	${RM} ${references}
