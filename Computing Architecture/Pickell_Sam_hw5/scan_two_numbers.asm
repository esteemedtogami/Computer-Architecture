/****************************
Author:	 Sam Pickell
Date:	 November 7, 2017
Filename: scan_two_numbers.asm
****************************/

start:	  	lodd on:
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
	        lodd on:	; mic1 program to print string
	        stod 4093	; and scan in a 1-5 digit number
bgndig:	 	call rbsywt:	; using CSR memory locations
	        lodd 4092
	        subd numoff:
	        push
nxtdig:	 	call rbsywt:
	        lodd 4092
	        stod nxtchr:
	        subd nl:
	        jzer endnum:
	        mult 10
	        lodd nxtchr:
	        subd numoff:
	        addl 0
	        stol 0
	        jump nxtdig:
endnum:	 	lodd numptr:
	        popi
	        addd c1:
	        stod numptr:
	        lodd numcnt:
	        jzer addnms:
	        subd c1:
	        stod numcnt:
	        jump start:
addnms:	 	lodd sum:	;Started work here
		addd binum1:    ;add binum1 to sum
	        stod sum:       ;store result in sum
	        lodd sum:       ;load sum
	        addd binum2:    ;add the other binum here
		stod sum:	;store in sum the final sum
		loco maxval:    ;load the max value before overflow
	        subd sum:       ;subtract the sum from maxval
	        jneg overflow:  ;if neg, sum > maxval and there's an overflow
decode1:	lodd sum:	;load sum
	        div  10		;divide sum by 10 so rightmost digit is the remainder
	        desp 1		;decrement sp by 1 so we are at the location on the stack
				        ;where the remainder is
	        lodl 1          ;load remainder into ac
	        addd numoff:    ;add 48 to the remainder to get ascii representation
	        stod remainder: ;store the result in remainder var
		lodd output:	;load output
		addd remainder: ;add remainder value to output string
	        stod output:	;store result in output
	        desp 1 		;decrement the sp to get to quotient location in stack
	        lodl 0		;load quotient
	        jzer finish:	;if the quotient is zero, we're done
	        stod sum:	;otherwise, this is the new quotient to work with
	        pop		;reset stack
	        pop
decode2:	lodd sum:	;most of decode2 is the same as decode1 but I will
				;comment on different parts 
		div  10
		desp 1
		lodl 1
		addd numoff:
		stol 1
	        lodd output:	
		rshift 8	;rshift to make room for the next 8bit ascii representation
		stod output:
	        lodl 1
	        addd output:
	        stod output:
		desp 1
	        lodl 0
		jzer finish:
		pop
		pop
		jump decode2: 	;repeat because the quotient wasn't zero
xbsywt:	 	lodd 4095
	        subd mask:
	        jneg xbsywt:
	        retn
rbsywt:	 	lodd 4093
	        subd mask:
	        jneg rbsywt:
	        retn
sb:	     	loco 8
loop1:	  	jzer finish:
	        subd c1:
	        stod lpcnt:
	        lodl 1
	        jneg add1:
	        addl 1
	        stol 1
	        lodd lpcnt:
	        jump loop1:
add1:	   	addl 1
	        addd c1:
	        stol 1
	        lodd lpcnt:
	        jump loop1:
finish:		lodl 1
	        retn
done:		lodd on:	;this is supposed to print for no overflow but doesn't print
	        stod 4095
	        call xbsywt:
	        loco str2:
	        lodd on:
	        call nextw:
	        stod 4095
	        call xbsywt:
	        loco output:
		call nextw:
	        halt
overflow:	lodd on:	;this is supposed to print for overflow but does not print
	        stod 4095
	        call xbsywt:
	        loco str2:
	        lodd on:
	        stod 4095
	        call xbsywt:
	        loco output:
	        halt
numoff:	 48
nxtchr:	 0
numptr:	 binum1:
binum1:	 0
binum2:	 0
lpcnt:	 0
mask:	 10
on:	 8
nl:	 10
cr:	 13
c1:	 1
c10:	 10
c255:	 255
sum:	 0
output:	 0
remainder: 0
numcnt:	 1
pstr1:	 0
maxval:	 32767
str1:	 "Please enter a 1-5 digit number followed by enter"
str2:	 "The sum of these integers is:"
str3:	 "Overflow, no sum possible"
