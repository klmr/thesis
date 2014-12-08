LATEXMK = latexmk -xelatex -r .latexmkrc

target = thesis

.PHONY: ${target}
${target}: ${target}.pdf

${target}.pdf: ${target}.tex
	${LATEXMK} ${target}

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
