cputime = require '../'
assert = require "assert"

utils = require '../src/utils'

describe 'CPU Time', ->
	before (done) ->
		# do some job to get some cpu usage
		for i in [0..100000]
			"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vestibulum fermentum tortor id mi. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci. Nam sed tellus id magna elementum tincidunt. Praesent vitae arcu tempor neque lacinia pretium. Fusce aliquam vestibulum ipsum. Pellentesque pretium lectus id turpis. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Aliquam ornare wisi eu metus.".match(/([se]+)|([xa]+)|([ie]+)|([he]+)/g);
		
		done()
		
	it 'Process', (done) ->
		cputime.cpuTime (err, time) ->
			if err then return done err
		
			assert.ok time >= 0
			console.log 'Time:', time

			done()

describe 'Utils', ->
	it 'parsePS', (done) ->
		assert.equal 0.13, utils.parsePS '0.13'
		assert.equal 0.13, utils.parsePS '0:00.13'
		assert.equal 0.13, utils.parsePS '0:00:00.13'
		assert.equal 0.13, utils.parsePS '0-00:00:00.13'
		
		assert.equal 98920, utils.parsePS '1648:40'
		assert.equal 98920, utils.parsePS '27:28:40'
		assert.equal 98920, utils.parsePS '1-03:28:40'
		
		assert.equal 13, utils.parseTasklist 'CPU Time: 00:00:13'
		
		done()