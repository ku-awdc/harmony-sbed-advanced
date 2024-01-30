#SRC = $(wildcard S*/Session_*.Rmd)
SRC = S0_Preparation/Session_Preparation.Rmd S2_Simulation/Session_2.Rmd S3_SampleSize/Session_3.Rmd S4_Bonus/Session_4.Rmd

PDF   = $(SRC:.Rmd=.pdf)
HTML  = $(SRC:.Rmd=.html)
R     = $(SRC:.Rmd=.R)

RENDER_H = @Rscript -e "rmarkdown::render('$<', 'html_document', params=list(presentation=FALSE))" #; nf <- gsub('.Rmd', '.html', '$<'); file.copy(nf, '../', overwrite=TRUE)"
RENDER_P = @Rscript -e "rmarkdown::render('$<', 'beamer_presentation', params=list(presentation=TRUE))" #; nf <- gsub('.Rmd', '.pdf', '$<'); file.copy(nf, '../', overwrite=TRUE)"
RENDER_D = @Rscript -e "rmarkdown::render('$<', 'pdf_document', params=list(presentation=FALSE))" #; nf <- gsub('.Rmd', '.pdf', '$<'); file.copy(nf, '../', overwrite=TRUE)"
PURL = @Rscript -e "knitr::purl('$<', documentation = 2L, output = paste0(tools::file_path_sans_ext('$<'), '.R'))"

%.R:%.Rmd
	$(PURL)
%.html:%.Rmd
	$(RENDER_H)
	-rm -rf S*.log
%Session_Preparation.pdf:%Session_Preparation.Rmd
	$(RENDER_D)
	-rm -rf S*.log
%.pdf:%.Rmd
	$(RENDER_P)
	-rm -rf S*.log

.PHONY: clean
.PHONY: tidy
.PHONY: r
.PHONY: pdf
.PHONY: html
.PHONY: all
	
all: 	$(PDF) $(HTML) #$(R)
pdf:	$(PDF)
html:	$(HTML)
r: $(R)
clean:
	-rm -rf S*.md
	-rm -rf S*.tex
	-rm -rf S*.pdf
	-rm -rf S*.html
	-rm -rf S*.R
	-rm -rf S*.log
	-rm -rf S*_files
tidy:
	-rm -rf S*.md
	-rm -rf S*.tex
	-rm -rf S*.log
	-rm -rf S*_files
