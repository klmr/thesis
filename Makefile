fullpath := $(shell pwd -P)
LATEXMK := latexmk -xelatex -r ${fullpath}/.latexmkrc

target := thesis
includes := $(shell ls *.{tex,cls})

.PHONY: ${target}
${target}: ${target}.pdf

${target}.pdf: ${includes}

%.pdf: %.tex
	cd $$(dirname $@); ${LATEXMK} $$(basename $<)

.PHONY: preview
preview:
	${LATEXMK} -pvc ${target}

.PHONY: clean
clean:
	${RM} $(filter-out %.tex %.cls %.pdf,$(shell ls ${target}.*))
	${RM} ${target}-blx.bib

.PHONY: cleanall
cleanall: clean
	${RM} ${target}.pdf
