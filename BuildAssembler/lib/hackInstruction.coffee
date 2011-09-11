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
				when 'D' then '0001100'
				when 'A' then '0110000'
				when 'D+A' then '0000010'
