CC   ?= gcc

ifndef V
QUIET_CC         = @echo "CC	$@";
QUIET_MAKE_TESTS = @echo "GN	Alltests.c";
endif

DEPS = $(shell ls ../src/*.[ch])

SRC = $(shell ls *.c | sed 's/AllTests.c//')
OBJ = $(SRC:.c=.o)

ifndef DEBUG
ALL_CFLAGS  = -DNDEBUG -g2 -O2
else
ALL_CFLAGS  = -DDEBUG -g3 -O1
endif

ALL_CFLAGS  += -fPIC -Wall -Wextra -ansi -pedantic
ALL_CFLAGS  += $(CFLAGS)

INCLUDE = -I../src
LDFLAGS +=

all: check

check: testrun
	@./testrun

testrun: AllTests.o $(OBJ)
	$(QUIET_CC)$(CC) $(INCLUDE) $(CPPFLAGS) $(ALL_CFLAGS) $(OBJ) -o $@ AllTests.o

AllTests.o: $(OBJ)
	$(QUIET_MAKE_TESTS)./make-tests.sh > AllTests.c
	$(QUIET_CC)$(CC) $(INCLUDE) $(CPPFLAGS) $(ALL_CFLAGS) -c -o AllTests.o AllTests.c

%.o: %.c $(DEPS)
	$(QUIET_CC)$(CC) $(INCLUDE) $(CPPFLAGS) $(ALL_CFLAGS) -c -o $@ $<

clean veryclean:
	rm -rf AllTests.c
	rm -rf $(OBJ) AllTests.o
	rm -rf testrun
