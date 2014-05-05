

all: asciidoc

asciidoc: *.txt
	mkdir html/; \
	for f in $?; do \
		a2x -fxhtml -D html/ "$$f"; \
	done
#	echo "" >html/index.txt 
#	cd html
#	for i in *.html; do \
#		echo "link:"$$i"[$${i}]">> index.txt; \
#		echo "">>index.txt; \
#	done
#	a2x -fxhtml index.txt
#	cd ..

clean:
	rm -rf html/
