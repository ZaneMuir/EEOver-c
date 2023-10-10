CC      = g++
cc     = gcc
CFLAGS  = -Wall -g #--coverage
LDFLAGS = -lgsl -lgslcblas #--coverage

OBJ = call_ee.o solvers.o zsolve_quartic.o Roots3And4.o
LIB = solvers.o zsolve_quartic.o Roots3And4.o
ifeq ($(OS), Windows_NT)
	LIBNAME = eeover.dll
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S), Linux)
		LIBNAME = eeover.so
	endif
	ifeq ($(UNAME_S), Darwin)
		LIBNAME = eeover.dylib
	endif
endif

library: build-all
	$(cc) -shared $(LIB) -o $(LIBNAME) $(LDFLAGS)

prog: build-all call_ee.o
	$(CC) $(CFLAGS) -o overlap $(OBJ) $(LDFLAGS)

build-all: $(LIB)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

.PHONY: clean
clean:
	rm -rf $(BIN) $(OBJ) $(LIBNAME) *.gcda *gcno
gcov:
	gcovr -r . --html -o coverage.html --html-details
