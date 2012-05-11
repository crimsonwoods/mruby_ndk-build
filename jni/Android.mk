LOCAL_PATH  := $(call my-dir)
BASE_CFLAGS := -Wall -Werror-implicit-function-declaration -O3
RUBY_ROOT   := ../..
YACC        := bison
YC          := $(RUBY_ROOT)/src/y.tab.c
YSRC        := $(RUBY_ROOT)/src/parse.y
DLIB        := $(RUBY_ROOT)/mrblib/mrblib.ctmp
RLIB        := $(RUBY_ROOT)/mrblib/mrblib.rbtmp
MRBS        := $(RUBY_ROOT)/mrblib/*.rb

include $(CLEAR_VARS)

$(shell $(YACC) -o $(YC) $(YSRC))

LOCAL_MODULE    := mruby
LOCAL_CFLAGS    := $(BASE_CFLAGS)
LOCAL_C_INCLUDES:= $(RUBY_ROOT)/include $(RUBY_ROOT)/src
LOCAL_SRC_FILES := $(RUBY_ROOT)/tools/mruby/mruby.c
LOCAL_LDLIBS    := -lm
LOCAL_STATIC_LIBRARIES := mruby_lib mrblib

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE           := mruby_lib
LOCAL_CFLAGS           := $(BASE_CFLAGS)
LOCAL_C_INCLUDES       := $(RUBY_ROOT)/include $(RUBY_ROOT)/src
LOCAL_SRC_FILES        := $(wildcard $(RUBY_ROOT)/src/*.c)
LOCAL_LDLIBS           :=
LOCAL_SHARED_LIBRARIES :=

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

$(shell cat $(MRBS) > $(RLIB))
$(shell $(RUBY_ROOT)/bin/mrbc -Bmrblib_irep -o$(DLIB) $(RLIB))
$(shell cat $(RUBY_ROOT)/mrblib/init_mrblib.c $(DLIB) > $(RUBY_ROOT)/mrblib/mrblib.c)

LOCAL_MODULE           := mrblib
LOCAL_CFLAGS           := $(BASE_CFLAGS)
LOCAL_C_INCLUDES       := $(RUBY_ROOT)/include $(RUBY_ROOT)/src
LOCAL_SRC_FILES        := $(RUBY_ROOT)/mrblib/mrblib.c
LOCAL_LDLIBS           :=
LOCAL_SHARED_LIBRARIES :=

include $(BUILD_STATIC_LIBRARY)
