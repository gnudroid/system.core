
ROOT := ..

include $(ROOT)/buildconf.mk

LIBRARY_NAME := $(LIBANDROID_ZIPARCHIVE_LIBNAME)

SRCS := \
    zip_archive.cc \
    zip_archive_stream_entry.cc \
    zip_writer.cc \

OBJS := $(SRCS:.cc=.o)

# ZLIB_CONST turns on const for input buffers, which is pretty standard.
CPPFLAGS += \
    -DZLIB_CONST \
    -Werror \
    -Wall \
    $(LIBANDROID_BASE_CPPFLAGS) \
    $(LIBANDROID_LOG_CPPFLAGS)

# Incorrectly warns when C++11 empty brace {} initializer is used.
# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61489
CXXFLAGS += \
    -std=c++11 \
    -Wold-style-cast \
    -Wno-missing-field-initializers \

LIBS += \
    $(ZLIB_LIBS) \
    $(LIBANDROID_LOG_LIBS)

library_so   := lib$(LIBRARY_NAME).so

all:	$(library_so)

$(library_so):	$(OBJS)
	$(CXX) $(LIBS) -shared -Wl,--no-undefined -pthread -o $@ $(OBJS)

clean:
	@rm -f *.o *.so *.so.* $(library_so)
