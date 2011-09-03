	// Store the max position for the screen in @smax
	@24576
	D=A
	@smax
	M=D

	@index
	M=0
(LOOP)
	// Read the keyboard
	@24576
	D=M
	@LOOP
	D;JEQ // No key pressed, go back and look again

	// Initialize the index to the start of the screen
	@SCREEN
	D=A
	@index
	M=D
(DARKLOOP)
	@index
	D=M
	@smax
	D=D-M
	@LOOP
	D;JGE // If (index-screenmax)>=0 GOTO LOOP

	// Darken the screen bits
	@index
	D=M
	@SCREEN
	A=D
	M=!M
	
	@index
	M=M+1
	@DARKLOOP
	0;JMP // DARKLOOP
(END)
	@END
	0;JMP // Infinite Loop (Terminator)

