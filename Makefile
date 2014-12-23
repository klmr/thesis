fullpath := $(shell pwd -P)
LATEXMK = latexmk -xelatex -r ${fullpath}/.latexmkrc

target = thesis

.PHONY: ${target}
${target}: ${target}.pdf

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
