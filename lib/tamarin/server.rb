require "tamarin/connection"

module Tamarin

	class Server

		attr_accessor :server
		
		def initialize(port)
			@server = TCPServer.new(port)
		end

		def start
			loop do
				socket = server.accept
				connection = Connection.new(socket)
				connection.process
			end
		end

	end
	
end