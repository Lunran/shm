.PHONY: all clean

all: cup.stl cup_with_pipe.stl

%.stl: %.scad
	openscad -o $@ $<

clean:
	rm -f *.stl
