cp = require 'child_process'
os = require 'os'
fs = require 'fs'

utils = require './utils'

CLK_TCK = 100

if os.platform() is 'linux'
	cp.exec "getconf CLK_TCK", (err, stdout, stderr) ->
		if err then return
		
		CLK_TCK = parseFloat stdout

###
@param {Number} [pid] Process ID.
@callback done Callback.
	@param {Error} err Error or null.
	@param {Number} time CPU time.
###

module.exports.cpuTime = (pid, done) ->
	if pid instanceof Function
		done = pid
		pid = process.pid
	
	if isNaN(pid)
		setImmediate -> done new Error "Invalid process ID - '#{pid}'."
		return
	
	switch os.platform()
		when 'linux'
			fs.readFile "/proc/#{pid}/stat", "ascii", (err, data) ->
				if err then return done err
				
				parts = data.split ' '
				done null, (parseInt(parts[13]) + parseInt(parts[14])) / CLK_TCK
			
		when 'darwin'
			cp.exec "ps -p #{pid} -o time", (err, stdout, stderr) ->
				if err then return done err
				
				done null, utils.parsePS stdout
		
		when 'win32'
			cp.exec "tasklist /v /fi \"pid eq #{pid}\" /fo list", (err, stdout, stderr) ->
				if err then return done err
				
				done null, utils.parseTasklist stdout
		
		else
			setImmediate -> done new Error "Unsupported platform '#{os.platform()}'."
			return