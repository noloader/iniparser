#
# iniparser tests Makefile
#

CC      ?= gcc

ifndef DEBUG
ALL_CFLAGS  = -DNDEBUG -g2 -O2
else
ALL_CFLAGS  = -DDEBUG -g3 -O1
endif

ALL_CFLAGS  += -fPIC -Wall -Wextra -ansi -pedantic
ALL_CFLAGS  += $(CFLAGS)

LFLAGS  += -L.. -liniparser
AR	    ?= ar
ARFLAGS += rcv
RM      ?= rm -f

default: all

all: iniexample parse

iniexample: iniexample.c
	$(CC) $(CPPFLAGS) $(ALL_CFLAGS) -o iniexample iniexample.c -I../src -L.. -liniparser

parse: parse.c
	$(CC) $(CPPFLAGS) $(ALL_CFLAGS) -o parse parse.c -I../src -L.. -liniparser

clean veryclean:
	$(RM) iniexample example.ini parse
