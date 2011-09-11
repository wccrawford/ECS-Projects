#!/usr/local/bin/coffee

{hackCompiler} = require './lib/hackCompiler'

args = process.ARGV[2..]

compiler = new hackCompiler

compiled = compiler.compile args[0]

compiler.saveFile args[1], compiled
