{hackInstruction} = require './hackInstruction'

class exports.hackParser
	parse: (lines) ->
		lines = @stripComments lines

		@instructions = []
		for lineNumber, line of lines
			instructions = line.split ';'
			for cmNum, instruction of instructions
				@parseInstruction instruction
	
	parseInstruction: (line) ->
		switch line[0]
			when '@'
				instruction = new hackInstruction line
				instruction.value = line[1..]
				console.log(instruction)
			else
				if line.indexOf '='
					instruction = new hackInstruction line
					eqSplit = line.split '='
					for charNum, char of eqSplit[0]
						instruction.store.push char
					instruction.calculation = eqSplit[1]
					console.log(instruction)
				else
					commmand = new hackInstruction line

	stripComments: (contents) ->
		lines = for lineNumber, line of contents.split("\n")
			split = line.split '//'
			cleanLine = @trim split[0]

		for lineNumber, line of lines when line != ''
			line

	trim: (str) ->
		str.replace /^\s+|\s+$/, ""

