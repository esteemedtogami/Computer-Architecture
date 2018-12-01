C=g++ -g -Wall --std=c++14 -Werror
E=.cpp
O=main.o
P=program1
all: $(P)
$(P):$(O)
	$(C) -o $(P) $(O)

$(E).o:
	$(C) -c $<  -o $@

clean:
	rm $(O) $(P)
