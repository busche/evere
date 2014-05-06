

SUBDIRS = book docs
     
.PHONY: subdirs $(SUBDIRS)

all: subdirs

subdirs: $(SUBDIRS)
	     
$(SUBDIRS):
	$(MAKE) -C $@

clean: 
