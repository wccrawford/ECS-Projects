{hackInstruction} = require './hackInstruction'

class exports.hackParser
	constructor: ->
		@symbols = {
			SP: 0,
			LCL: 1,
			ARG: 2,
			THIS: 3,
			THAT: 4,
			R0: 0,
			R1: 1,
			R2: 2,
			R3: 3,
			R4: 4,
			R5: 5,
			R6: 6,
			R7: 7,
			R8: 8,
			R9: 9,
			R10: 10,
			R11: 11,
			R12: 12,
			R13: 13,
			R14: 14,
			R15: 15,
			SCREEN: 16384,
			KBD: 24576,
		}

	@freeLocation = 16

	addSymbol: (symbol, value=null) ->
		return @symbols[symbol] if @symbols[symbol] != undefined

		if value == null
			value = @freeLocation
			@freeLocation++

		@symbols[symbol] = value

	parse: (lines) ->
		lines = @stripComments lines

		@instructions = []
		for lineNumber, line of lines
			instructions = line.split ';'
			for cmNum, instruction of instructions
				@parseInstruction instruction

		for insNumber, instruction of @instructions
			if instruction.value == null
				continue

			if !@isNumeric instruction.value
				console.log instruction.value
				@instructions[insNumber].value = @addSymbol instruction.value
				console.log @instructions[insNumber].value

		console.log @instructions
		compiled = []
		for insNumber, instruction of @instructions
			compiled.push instruction.compile()

		console.log compiled
		console.log @symbols
		return compiled
	
	parseInstruction: (line) ->
		line = @trim line

		switch line[0]
			when '@'
				instruction = new hackInstruction line
				instruction.value = line[1..]
				@instructions.push instruction
			when '('
				symbol = line.replace /[()]/g, ""
				@addSymbol symbol, @instructions.length
			else
				if line.indexOf('=') != -1
					instruction = new hackInstruction line
					eqSplit = line.split '='
					for charNum, char of eqSplit[0]
						instruction.store.push char
					instruction.calculation = eqSplit[1]
					@instructions.push instruction
				else if line[0] == 'J'
					instruction = @instructions[@instructions.length-1]
					instruction.jmp = switch line
						when "JGT" then ['gt']
						when "JGE" then ['gt', 'eq']
						when "JLT" then ['lt']
						when "JLE" then ['lt', 'eq']
						when "JEQ" then ['eq']
						when "JMP" then ['lt', 'eq', 'gt']
				else
					instruction = new hackInstruction line
					instruction.calculation = line
					@instructions.push instruction

	stripComments: (contents) ->
		lines = for lineNumber, line of contents.split("\n")
			split = line.split '//'
			cleanLine = @trim split[0]

		for lineNumber, line of lines when line != ''
			line

	trim: (str) ->
		str.replace /^\s+|\s+$/, ""
	
	isNumeric: (str) ->
		!isNaN(parseFloat(str)) && isFinite(str)

