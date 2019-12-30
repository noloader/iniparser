#
# iniparser Makefile
#
.PHONY: example

# Compiler settings
CC      ?= gcc

ifndef DEBUG
ALL_CFLAGS  = -DNDEBUG -g2 -O2
else
ALL_CFLAGS  = -DDEBUG -g3 -O1
endif

ALL_CFLAGS  += -fPIC -Wall -Wextra -ansi -pedantic
ALL_CFLAGS  += $(CFLAGS)

# Ar settings to build the library
AR	    ?= ar
ARFLAGS = rcv

SHLD = $(CC) $(ALL_CFLAGS)
LDSHFLAGS = -shared -Wl,-Bsymbolic
LDFLAGS += -Wl,-rpath -Wl,/usr/lib -Wl,-rpath,/usr/lib

# .so.0 is for version 3.x, .so.1 is 4.x
SO_TARGET ?= libiniparser.so.1

# Set RANLIB to ranlib on systems that require it (Sun OS < 4, Mac OSX)
# RANLIB  = ranlib
RANLIB = true

RM      ?= rm -f


# Implicit rules

SUFFIXES = .o .c .h .a .so .sl

ifndef V
QUIET_AR      = @echo "AR	$@";
QUIET_CC      = @echo "CC	$@";
QUIET_LINK    = @echo "LINK	$@";
QUIET_RANLIB  = @echo "RANLIB	$@";
endif

SRCS = src/iniparser.c \
	   src/dictionary.c

OBJS = src/iniparser.o \
	   src/dictionary.o

default:	libiniparser.a $(SO_TARGET)

libiniparser.a:	$(OBJS)
	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $(subst src/,,$(OBJS))
	$(QUIET_RANLIB)$(RANLIB) $@

$(SO_TARGET): $(OBJS)
	$(QUIET_LINK)$(SHLD) $(LDSHFLAGS) $(LDFLAGS) -o $(SO_TARGET) $(subst src/,,$(OBJS)) -Wl,-soname=`basename $(SO_TARGET)`

clean:
	$(RM) $(OBJS)
	@(cd test ; $(MAKE) clean)

veryclean:
	$(RM) $(OBJS) libiniparser.a $(SO_TARGET)
	rm -rf ./html ; mkdir html
	cd example ; $(MAKE) veryclean
	cd test ; $(MAKE) veryclean

docs:
	@(cd doc ; $(MAKE))

check: $(SO_TARGET)
	@(cd test ; $(MAKE))

example: libiniparser.a
	@(cd example ; $(MAKE))	

.c.o:
	$(QUIET_CC)$(CC) $(CPPFLAGS) $(ALL_CFLAGS) $(TARGET_ARCH) -c $<
