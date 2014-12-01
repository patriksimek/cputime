module.exports.parsePS = (stdout) ->
	m = stdout.match /(?:(\d+)-)?(?:(?:(\d+):)?(\d+):)?(\d+)(?:\.(\d+))?/
	if not m then return 0
	
	t = 0
	if m[1]? then t += parseInt(m[1]) * 60 * 60 * 24
	if m[2]? then t += parseInt(m[2]) * 60 * 60
	if m[3]? then t += parseInt(m[3]) * 60
	if m[4]? then t += parseInt(m[4])
	if m[5]? then t += parseInt(m[5]) * .01
	
	t

module.exports.parseTasklist = (stdout) ->
	t = 0
	
	lines = stdout.toString().split '\n'
	for line in lines when -1 isnt line.indexOf 'CPU Time:'
		m = line.match /(?:(?:(\d+):)?(\d+):)?(\d+)/
		if not m then break
		
		if m[1]? then t += parseInt(m[1]) * 60 * 60
		if m[2]? then t += parseInt(m[2]) * 60
		if m[3]? then t += parseInt(m[3])
		
		break
	
	t