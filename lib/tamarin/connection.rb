module Tamarin
	
	class Connection

		attr_accessor :socket
		
		def initialize(socket)
			@socket = socket
		end

		def process
			data = socket.readpartial(1024)
			puts data
			write_response
			close			
		end

		def write_response
			socket.write "HTTP/1.1 200 OK\r\n"
			socket.write "\r\n"
			socket.write "hello\n"			
		end

		def close
			socket.close
		end

	end

end