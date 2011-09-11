{hackInstruction} = require './hackInstruction'

class exports.hackParser
	parse: (lines) ->
		lines = @stripComments lines

		@instructions = []
		for lineNumber, line of lines
			instructions = line.split ';'
			for cmNum, instruction of instructions
				@parseInstruction instruction

		console.log @instructions
		compiled = []
		for insNumber, instruction of @instructions
			compiled.push instruction.compile()

		console.log compiled
		return compiled
	
	parseInstruction: (line) ->
		switch line[0]
			when '@'
				instruction = new hackInstruction line
				instruction.value = line[1..]
				@instructions.push instruction
			else
				if line.indexOf '=' != -1
					instruction = new hackInstruction line
					eqSplit = line.split '='
					for charNum, char of eqSplit[0]
						instruction.store.push char
					instruction.calculation = eqSplit[1]
					@instructions.push instruction
				else
					instruction = new hackInstruction line
					@instructions.push instruction

	stripComments: (contents) ->
		lines = for lineNumber, line of contents.split("\n")
			split = line.split '//'
			cleanLine = @trim split[0]

		for lineNumber, line of lines when line != ''
			line

	trim: (str) ->
		str.replace /^\s+|\s+$/, ""

