CC = gcc
CFLAGS = -Wall -g -fPIC #--coverage
LIBCFLAGS = -Wall -shared
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

library: $(LIB)
	$(CC) $(LIB) $(LIBCFLAGS) -o $(LIBNAME) $(LDFLAGS)

prog: $(OBJ)
	$(CC) $(CFLAGS) -o overlap $(OBJ) $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

julia-lib: library clean

.PHONY: clean
clean:
	rm -rf $(BIN) $(OBJ) *.gcda *gcno
clean-julia:
	rm -rf $(LIBNAME)
gcov:
	gcovr -r . --html -o coverage.html --html-details
