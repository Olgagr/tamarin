require "tamarin/version"
require "tamarin/server"
require "tamarin/runner"

app = Tamarin::Runner.parse_file('lib/tamarin/config.ru')
server = Tamarin::Server.new(3030, app)
puts "Server listening on port 3030"
server.start
