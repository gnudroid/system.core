
SUBDIRS := liblog libcutils

all:
	@for d in $(SUBDIRS) ; do $(MAKE) -C $$d ; done

install:
	@for d in $(SUBDIRS) ; do $(MAKE) -C $$d install ; done

clean:
	@for d in $(SUBDIRS) ; do $(MAKE) -C $$d clean ; done
