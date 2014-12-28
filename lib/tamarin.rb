require "tamarin/version"
require "tamarin/server"


app = proc { 
	[
		200,
		{ 'Content-Type' => 'text/plain' },
		['This is a message from rack app']
	]
}
server = Tamarin::Server.new(3030, app)
puts "Server listening on port 3030"
server.start
