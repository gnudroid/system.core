
ROOT := ..

include $(ROOT)/buildconf.mk

library-name		:= $(LIBANDROID_BASE_LIBNAME)
library-lang		:= c++

library-version-major	:= 1
library-version-minor	:= 0
library-version-patch	:= 0

library-srcs-y	+= \
    file.cpp \
    logging.cpp \
    parsenetaddress.cpp \
    stringprintf.cpp \
    strings.cpp \
    test_utils.cpp \

library-srcs-$(CONFIG_TARGET_LINUX) := errors_unix.cpp

library-cppflags-y := \
    -Wall \
    -Wextra \
    -Werror \
    $(LIBANDROID_BASE_CPPFLAGS) \
    $(LIBANDROID_LOG_CPPFLAGS)

library-libs-y := \
    $(LIBANDROID_LOG_LIBS)

library-hdrs-src := include/android-base/*.h
library-hdrs-dir := android/android-base

include $(ROOT)/library.mk
