fs = require 'fs'

{hackInstruction} = require './hackInstruction'
{hackParser} = require './hackParser'

class exports.hackCompiler
	compile: (file) ->
		contents = @loadFile file

		parser = new hackParser
		compiled = parser.parse contents

		lines = ''
		for line in compiled
			lines += line + "\n"

		return lines

	loadFile: (file) ->
		fs.readFileSync file, 'utf8'

	saveFile: (file, contents) ->
		fs.writeFileSync file, contents, 'utf8'
