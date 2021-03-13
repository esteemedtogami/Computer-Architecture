C=g++ -g -Wall --std=c++98 -Werror
E=.cpp
O=main.o
P=program_7
all: $(P)
$(P):$(O)
	$(C) -o $(P) $(O)

$(E).o:
	$(C) -c $<  -o $@

clean:
	rm $(O) $(P)
