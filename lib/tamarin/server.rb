require "tamarin/connection"

module Tamarin

	class Server

		attr_accessor :server
		
		def initialize(port, app)
			@server = TCPServer.new(port)
			@app = app
		end

		def start
			loop do
				socket = server.accept
				connection = Connection.new(socket, @app)
				connection.process
			end
		end

	end
	
end