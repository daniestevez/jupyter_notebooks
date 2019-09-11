CPPFLAGS=-D_RTLDLL -DNO_STRICT -DTRACE -DENAGLO -DENAQZS -DENAGAL -DENACMP -DENAIRN -DNFREQ=3 -DNEXOBS=3 -DEXTLEX -DQT_NO_DEBUG
CFLAGS=-Wall -O2 -g
LDLIBS=-lm

all: compute_satpos compute_satpos_nofutureeph

compute_satpos: compute_satpos.o
	$(CC) $(LDFLAGS) $^ -o $@ $(LOADLIBES) $(LDLIBS) -lRTKLib

compute_satpos_nofutureeph: compute_satpos.o
	$(CC) $(LDFLAGS) $^ -o $@ $(LOADLIBES) $(LDLIBS) -lRTKLib_nofutureeph
clean:
	rm -f compute_satpos compute_satpos_nofutureeph *.o
