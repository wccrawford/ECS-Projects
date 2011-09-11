class exports.hackInstruction
	constructor: (@line) ->
		@value = null
		@labels = []
		@store = []
		@calculation = null
		@jmp = []
	
	compile: ->
		if @value != null
			@compileValue()
		else
			@compileCommand()

	compileValue: ->
		output =''

		for index in [0..14]
			digit = if (@value & (1 << index)) != 0 then '1' else '0'
			output = digit + output

		output = '0' + output

		return output

	compileCommand: ->
		'111' + @aluBits() + @dstBits() + @jmpBits()

	jmpBits: ->
		(if @jmp.indexOf('lt') != -1 then '1' else '0') +
		(if @jmp.indexOf('eq') != -1 then '1' else '0') +
		(if @jmp.indexOf('gt') != -1 then '1' else '0')
	
	dstBits: ->
		(if @store.indexOf('A') != -1 then '1' else '0') +
		(if @store.indexOf('D') != -1 then '1' else '0') +
		(if @store.indexOf('M') != -1 then '1' else '0')
	
	aluBits: ->
		if @calculation != null
			calculation = @calculation.replace(/\s/, "")

			switch calculation
				when '0'          then '0101010'
				when '1'          then '0111111'
				when '-1'         then '0111010'
				when 'D'          then '0001100'
				when 'A'          then '0110000'
				when 'M'          then '1110000'
				when '!D'         then '0001101'
				when '!A'         then '0110001'
				when '!M'         then '1110001'
				when '-D'         then '0001111'
				when '-A'         then '0110011'
				when '-M'         then '1110011'
				when 'D+1'        then '0011111'
				when 'A+1'        then '0110111'
				when 'M+1'        then '1110111'
				when 'D-1'        then '0001110'
				when 'A-1'        then '0110010'
				when 'M-1'        then '1110010'
				when 'D+A', 'A+D' then '0000010'
				when 'D+M', 'M+D' then '1000010'
				when 'D-A'        then '0010011'
				when 'D-M'        then '1010011'
				when 'A-D'        then '0000111'
				when 'M-D'        then '1000111'
				when 'D&A'        then '0000000'
				when 'D&M'        then '1000000'
				when 'D|A'        then '0010101'
				when 'D|M'        then '1010101'
