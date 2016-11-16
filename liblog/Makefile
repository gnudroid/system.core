
ROOT	:= ..

all:	all-libs

include $(ROOT)/buildconf.mk

# FIXME: event.logtags

library-name		:= $(LIBANDROID_LOG_LIBNAME)
library-version-major	:= 1
library-version-minor	:= 0
library-version-patch	:= 0

library-srcs-y	:= \
    log_event_list.c	\
    log_event_write.c	\
    logger_write.c	\
    config_write.c	\
    logger_name.c	\
    logger_lock.c	\
    event_tag_map.c

library-srcs-$(CONFIG_TARGET_ANDROID)	+= \
    config_read.c 	\
    log_time.cpp	\
    log_is_loggable.c	\
    logprint.c		\
    pmsg_reader.c	\
    pmsg_writer.c	\
    logd_reader.c	\
    logd_writer.c	\
    logger_read.c

library-srcs-$(CONFIG_TARGET_LINUX)	+= \
    fake_log_device.c	\
    fake_writer.c

library-cppflags-y	+= \
    $(LIBANDROID_LOG_CPPFLAGS)	\
    -DFAKE_LOG_DEVICE=1		\
    -Werror			\
    -fvisibility=hidden		\
    -DLIBLOG_LOG_TAG=1005	\
    -DSNET_EVENT_LOG_TAG=1397638484

library-hdrs-src := $(ROOT)/include/log/*.h
library-hdrs-dir := android/log

include $(ROOT)/library.mk
