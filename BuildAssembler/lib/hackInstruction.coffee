class exports.hackInstruction
	constructor: (@line) ->
		@value = null
		@labels = []
		@store = []
		@calculation = null
		
