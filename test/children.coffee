cputime = require '../'
assert = require "assert"
cp = require 'child_process'

utils = require '../lib/utils'

describe 'Child Processes', ->
	cputime.includeChildProcesses = true
	
	it 'should measure CPU with child process', (done) ->
		cputime.cpuTime (err, time) ->
			if err then return done err
		
			console.log 'Time:', time
			
			cp.exec "node -e \"var i = 0;while(i++ < 200000){'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vestibulum fermentum tortor id mi. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci. Nam sed tellus id magna elementum tincidunt. Praesent vitae arcu tempor neque lacinia pretium. Fusce aliquam vestibulum ipsum. Pellentesque pretium lectus id turpis. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Aliquam ornare wisi eu metus.'.match(/([se]+)|([xa]+)|([ie]+)|([he]+)/g)};\"", (err, stdout, stderr) ->
				if err then return done err
				
				cputime.cpuTime (err, time) ->
					if err then return done err
				
					console.log 'Time:', time
	
					done()

	it 'should measure CPU with child process 2', (done) ->
		cputime.cpuTime (err, time) ->
			if err then return done err
		
			console.log 'Time:', time
			
			cp.exec "node -e \"setTimeout(function(){process.exit()},2000);\"", (err, stdout, stderr) ->
				if err then return done err
				
				cputime.cpuTime (err, time) ->
					if err then return done err
				
					console.log 'Time:', time
	
					done()