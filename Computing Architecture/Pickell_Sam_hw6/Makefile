C=g++ -g  --std=c++98
E=.cpp
O=linker.o
P=my_linker
all: $(P)
$(P):$(O)
	$(C) -o $(P) $(O)

$(E).o:
	$(C) -c $<  -o $@

clean:
	rm $(O) $(P)
