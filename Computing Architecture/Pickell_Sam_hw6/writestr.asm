start:	  	lodd on3:
	        stod 4095
	        call xbsywt:
	        loco str1:
nextw:	  	pshi
	        addd c1:
	        stod pstr1:
	        pop
	        jzer crnl:
	        stod 4094
	        push
	        subd c255:
	        jneg crnl:
	        call sb:
	        insp 1
	        push
	        call xbsywt:
	        pop
	        stod 4094
	        call xbsywt:
	        lodd pstr1:
	        jump nextw:
crnl:	   	lodd cr:
	        stod 4094
	        call xbsywt:
	        lodd nl:
	        stod 4094
	        call xbsywt:
	        lodd on3:
	        stod 4093
		retn
nl:	     10
cr:	     13
c1:	     1
c255:	   255
pstr1:	  0
str1:	   "This is a sample string"
on3:	8
sb:	 loco 8
