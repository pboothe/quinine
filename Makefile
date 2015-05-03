CC=clang
C_FILES=program.c
H_FILES=
SUPPORTING_FILES=Makefile quinine.sh

.PHONY: clean all
all: program quinine.py

quinine.py: $(SUPPORTING_FILES)
	./quinine.sh --lang python --code $@ $^

program: $(C_FILES) $(H_FILES) quinine.ch.intermediate
	$(CC) $(C_FILES) quinine.c -o $@

.INTERMEDIATE: quinine.ch.intermediate
quinine.ch.intermediate: $(C_FILES) $(H_FILES) $(SUPPORTING_FILES)
	./quinine.sh $^

clean:
	rm -f program quinine.c quinine.h quinine.py
