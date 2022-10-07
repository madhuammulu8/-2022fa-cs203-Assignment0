.SUFFIXES: 

default: 

PRIVATE_FILES=Assignment.key.ipynb admin .git  Assignment-equinix.key.ipynb

STUDENT_EDITABLE_FILES=hello_world2.cpp

.PHONY: create-labs

COMPILER=$(CXX) 
MICROBENCH_OPTIMIZE= -DHAVE_LINUX_PERF_EVENT_H -I$(PWD) -g 
LIBS= -lm -pthread 
BUILD=./build/

$(BUILD)perfstats.o: perfstats.c perfstats.h
	mkdir -p $(BUILD) 
	cp  $< $(BUILD)$<
	$(COMPILER) $(MICROBENCH_OPTIMIZE) $(LIBS) -o $(BUILD)perfstats.o -c $(BUILD)perfstats.c
	
$(BUILD)%.o: %.cpp
	mkdir -p $(BUILD) 
	cp  $< $(BUILD)$<
	$(COMPILER) $(MICROBENCH_OPTIMIZE) $(LIBS) -o $(BUILD)$*.o -c $(BUILD)$*.cpp

microbench.exe: $(BUILD)microbench.o $(BUILD)perfstats.o
	$(COMPILER) $(MICROBENCH_OPTIMIZE) $(LIBS) $(BUILD)microbench.o $(BUILD)perfstats.o  -o microbench.exe

%.exe: $(BUILD)%.o
	$(COMPILER) $(MICROBENCH_OPTIMIZE) $(LIBS) $< -o $*.exe

hello_world.exe: $(BUILD)hello_world.o

hello_world2.exe: $(BUILD)hello_world2.o

.PHONY: autograde

autograde: hello_world2.exe
	./hello_world2.exe

bitcount.exe: $(BUILD)bitcount.o

clean: 
	rm -f *.exe $(BUILD)*
#test
#test2
