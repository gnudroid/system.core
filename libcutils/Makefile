
ROOT := ../

all:	all-libs

include $(ROOT)/buildconf.mk

library-name		:= android_cutils
library-version-major	:= 1
library-version-minor	:= 0
library-version-patch	:= 0

library-srcs-y	+= \
	atomic.c \
	config_utils.c \
	fs_config.c \
	canned_fs_config.c \
	hashmap.c \
	iosched_policy.c \
	load_file.c \
	native_handle.c \
	open_memstream.c \
	process_name.c \
	record_stream.c \
	sched_policy.c \
	sockets.cpp \
	strdup16to8.c \
	strdup8to16.c \
	strlcpy.c \
	threads.c \
	fs.c \
	multiuser.c \
	socket_inaddr_any_server_unix.c \
	socket_local_client_unix.c \
	socket_local_server_unix.c \
	socket_loopback_client_unix.c \
	socket_loopback_server_unix.c \
	socket_network_client_unix.c \
	sockets_unix.cpp \
	str_parms.c \
	ashmem-host.c \
	trace-host.c \
	dlmalloc_stubs.c

library-srcs-$(CONFIG_ARCH_X86) += \
	arch-x86/android_memset16.S \
	arch-x86/android_memset32.S

library-srcs-$(CONFIG_ARCH_X86_64) += \
	arch-x86_64/android_memset16.S \
	arch-x86_64/android_memset32.S

library-srcs-$(CONFIG_ARCH_MIPS) += \
	arch-mips/android_memset.c

library-srcs-$(CONFIG-ARCH_MIPS64) += \
	arch-mips/android_memset.c

library-srcs-$(CONFIG_ARCH_ARM) += \
	arch-arm/memset32.S

library-srcs-$(CONFIG_ARCH_ARM64) += \
	arch-arm64/android_memset.S

library-srcs-$(CONFIG_TARGET_ANDROID) += \
	android_reboot.c \
	ashmem-dev.c \
	debugger.c \
	klog.c \
	partition_utils.c \
	properties.c \
	qtaguid.c \
	trace-dev.c \
	uevent.c

library-cflags-y += -Werror -Wall -Wextra -std=gnu90

library-cppflags-y += \
	$(LIBANDROID_CUTILS_CPPFLAGS) \
	$(LIBANDROID_LOG_CPPFLAGS)

library-libs-y += $(LIBANDROID_LOG_LIBS)

library-cppflags-$(CONFIG_CPUSETS)    += -DUSE_CPUSETS
library-cppflags-$(CONFIG_SCHEDBOOST) += -DUSE_SCHEDBOOST

library-hdrs-src := $(ROOT)/include/cutils/*.h
library-hdrs-dir := android/cutils

include $(ROOT)/library.mk
