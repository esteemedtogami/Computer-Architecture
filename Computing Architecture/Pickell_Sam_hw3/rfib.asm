/***************************
Author:	  Sam Pickell
Date:	  10/5/17
Filename: rfib.asm
***************************/
LOOP:	LODD PasCnt:
	JZER DONE:
	SUBD c1:
	STOD PasCnt:
P1:	LODD dadder:
	PSHI
	ADDD c1:
	STOD dadder:
	CALL FIB:
	INSP 1
P2:	PUSH
	LODD fadder:
	POPI
	ADDD c1:
	STOD fadder:
	JUMP LOOP:
FIB:	LODL 1
	JZER FIBZER:		;argument is 0
	SUBD c1:
	JZER FIBONE:		;argument is 1
	PUSH
	CALL FIB:		;fn1 = rfib(n-1)
	PUSH
	LODL 1
	SUBD c1:
	PUSH
	CALL FIB:		;fn2 = rfib(n-2)
	INSP 1
	ADDL 0			;fn1+fn2
	INSP 2
	RETN
FIBZER:	LODD c0:
	RETN
FIBONE:	LODD c1:
	RETN
DONE:	HALT
.LOC	100
d0:	3
	9
	18
	23
	25
f0:	0
	0
	0
	0
	0
dadder:	d0:
fadder:	f0:
c0:	0
c1:	1
c2:	2
PasCnt:	5
