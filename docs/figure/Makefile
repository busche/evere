
SUBDIRS = lifecycle

.PHONY: subdirs $(SUBDIRS)

all: subdirs

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	#rm -rf html/
