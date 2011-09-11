fs = require 'fs'

{hackInstruction} = require './hackInstruction'
{hackParser} = require './hackParser'

class exports.hackCompiler
	compile: (file) ->
		contents = @loadFile file

		parser = new hackParser
		compiled = parser.parse contents

	loadFile: (file) ->
		fs.readFileSync file, 'utf8'

