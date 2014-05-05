
SUBDIRS = 
     
.PHONY: subdirs $(SUBDIRS)

PDF_SOURCEFILES=evere.txt

all: pdf subdirs

book: book-pdf

book-pdf:
	mkdir -p book/pdf; \
	for f in $(PDF_SOURCEFILES); do\
		a2x -fpdf -dbook -D book/pdf/  $${f}; \
	done

book-html:
	mkdir -p book/html; \
	for f in $(PDF_SOURCEFILES); do \
		a2x -fxhtml -dbook -D book/html/ $${f}; \
	done

pdf: *.txt
#	for f in $?; do\
		a2x --verbose  -d book "$$f"; \
	done

# recursive invokation
subdirs: $(SUBDIRS)
	     
$(SUBDIRS):
	$(MAKE) -C $@

clean:
	rm -rf book/
