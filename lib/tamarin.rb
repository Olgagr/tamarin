require "tamarin/version"
require "tamarin/server"

server = Tamarin::Server.new(3030)
puts "Server listening on port 3030"
server.start
