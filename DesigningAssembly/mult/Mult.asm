	@2
	M=0 // sum = 0
	@index
	M=0 // index = 0
(LOOP)
	@index
	D=M
	A=0
	D=D-M
	@END
	D;JGE // If (index-RAM0)>=0 GOTO ANS
	@2
	D=M
	A=1
	D=D+M // D = D + RAM1
	@2
	M=D // Put D back in SUM
	@index
	M=M+1
	@LOOP
	0;JMP // LOOP
(END)
	@END
	0;JMP // Infinite Loop (Terminator)
