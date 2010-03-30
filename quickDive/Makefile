all: 
	$(MAKE) quickDiveXMCDA.pdf	

quickDiveXMCDA.pdf: quickDiveXMCDA.tex
	# makes a pdf directly
	pdflatex quickDiveXMCDA.tex
	# bibtex quickDiveXMCDA
	pdflatex quickDiveXMCDA.tex
	makeindex quickDiveXMCDA
	pdflatex quickDiveXMCDA.tex
	pdflatex quickDiveXMCDA.tex

clean:
	rm -f *~ *.aux  *.log *.backup *.bbl *.blg *.bak *.pyc *.lof *.lot *.toc *.mtc* *.bmt *.out *.brf *.idx *.ilg *.ind

veryClean:
	$(MAKE) clean
	rm -f *.pdf *.dvi *.ps
