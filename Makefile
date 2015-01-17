fullpath := $(shell pwd -P)
LATEXMK := latexmk -xelatex -r ${fullpath}/.latexmkrc

target := thesis
references := references.bib
includes := $(shell ls *.{tex,cls})
bib_sources := $(shell cat bib_sources.conf)

.PHONY: ${target}
${target}: ${target}.pdf

${target}.pdf: ${includes}

%.pdf: %.tex
	cd $$(dirname $@); ${LATEXMK} $$(basename $<)

.PHONY: preview
preview:
	${LATEXMK} -pvc ${target}

${references}: ${bib_sources}
	./scripts/import-paperpile ${bib_sources} > $@

.PHONY: clean
clean:
	${RM} $(filter-out %.tex %.cls %.pdf,$(shell ls ${target}.*))
	${RM} ${target}-blx.bib

.PHONY: cleanall
cleanall: clean
	${RM} ${target}.pdf
	${RM} ${references}
