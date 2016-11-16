
ifeq ($(library-name),)
$(error library-name is not set)
endif

ifeq ($(library-srcs-y),)
$(error library-srcs-y is not set)
endif

ifeq ($(library-version-major),)
$(error library-version-major is not set)
endif

ifeq ($(library-version-minor),)
$(error library-version-minor is not set)
endif

ifeq ($(library-version-patch),)
$(error library-version-patch is not set)
endif

CFLAGS		+= $(library-cflags-y) $(library-cflags-m)
CPPFLAGS	+= $(library-cppflags-y) $(library-cppflags-m)
CXXFLAGS	+= $(library-cxxflags-y) $(library-cxxflags-m)

DEPFLAGS    = -MT $@ -MMD -MP -MF $*.Td
COMPILE.c   = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) -c
COMPILE.cc  = $(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) -c
POSTCOMPILE = mv -f $*.Td $*.d

library-srcs-c		:= $(filter %.c,$(library-srcs-y) $(library-srcs-m))
library-srcs-cc		:= $(filter %.cc,$(library-srcs-y) $(library-srcs-m))
library-srcs-cpp	:= $(filter %.cpp,$(library-srcs-y) $(library-srcs-m))
library-srcs-s		:= $(filter %.S,$(library-srcs-y) $(library-srcs-m))

library-objs-c		:= $(library-srcs-c:.c=.o)
library-objs-cc		:= $(library-srcs-cc:.cc=.o)
library-objs-cpp	:= $(library-srcs-cpp:.cpp=.o)
library-objs-s		:= $(library-srcs-s:.S=.o)
library-objs		:= $(library-objs-c) $(library-objs-cc) $(library-objs-cpp) $(library-objs-s)

library-so		:= lib$(library-name).so.$(library-version-major).$(library-version-minor).$(library-version-patch)
library-link-a		:= lib$(library-name).so.$(library-version-major)
library-link-b		:= lib$(library-name).so

library-target		:= $(DESTDIR)$(LIBDIR)/$(library-so)

all-libs:	$(library-so) $(library-link-a) $(library-link-b)

clean-libs:
	@rm -f *.so *.so.* *.o *.d *.Td

install-libs:	$(library-so) $(library-link-a) $(library-link-b)
	@mkdir -p $(shell dirname $(library-target))
	@cp -d $(library-so) $(library-link-a) $(library-link-b) $(DESTDIR)$(LIBDIR)

clean::	clean-libs

install::	install-libs

$(library-so):		$(library-objs)
ifeq ($(library-lang),c++)
	@echo "[LD++] $(library-so)"
	@$(CXX) -shared -Wl,--no-undefined -pthread -o $@ $(library-objs) $(library-libs-y) $(library-libs-m)
else
	@echo "[LD  ] $(library-so)"
	@$(CC)  -shared -Wl,--no-undefined -pthread -o $@ $(library-objs) $(library-libs-y) $(library-libs-m)
endif
	@chmod -x $@

$(library-link-a):	$(library-so)
	@ln -sf $< $@

$(library-link-b):	$(library-link-a)
	@ln -sf $< $@

ifneq ($(library-hdrs-src),)
ifeq ($(library-hdrs-dir),)
$(error library-hdrs-src defined, but library-hdrs-dir missing)
endif

install:: install-hdrs

install-hdrs:
	@mkdir -p $(DESTDIR)$(INCLUDEDIR)/$(library-hdrs-dir)
	@cp -R $(library-hdrs-src) $(DESTDIR)$(INCLUDEDIR)/$(library-hdrs-dir)

endif

%.o : %.c
%.o : %.c %.d
	@echo "[CC  ] $@"
	@$(COMPILE.c) $(OUTPUT_OPTION) $<
	@$(POSTCOMPILE)

%.o : %.cc
%.o : %.cc %.d
	@echo "[C++ ] $@"
	@$(COMPILE.cc) $(OUTPUT_OPTION) $<
	@$(POSTCOMPILE)

%.o : %.cpp
%.o : %.cpp %.d
	@echo "[C++ ] $@"
	@$(COMPILE.cc) $(OUTPUT_OPTION) $<
	@$(POSTCOMPILE)

%.d: ;
.PRECIOUS: %.d

-include $(patsubst %,%.d,$(basename $(library-srcs-y) $(library-srcs-m)))
