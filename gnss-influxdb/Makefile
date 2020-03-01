CPPFLAGS=-D_RTLDLL -DNO_STRICT -DTRACE -DENAGLO -DENAQZS -DENAGAL -DENACMP -DENAIRN -DNFREQ=3 -DNEXOBS=3 -DEXTLEX -DQT_NO_DEBUG
CFLAGS=-Wall -O2 -g -fPIC
LDLIBS=-lm -lRTKLib

.PHONY: all clean

all: libgnsscalcs.so

libgnsscalcs.so: libgnsscalcs.o
	$(CC) -shared $^ -o $@ $(LOADLIBES) $(LDLIBS)

clean:
	rm -f libgnsscalcs.so *.o
