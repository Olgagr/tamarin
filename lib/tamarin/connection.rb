require 'http/parser'

module Tamarin
	
	class Connection

		attr_accessor :socket, :parser
		
		def initialize(socket)
			@socket = socket
			@parser = Http::Parser.new(self)
		end

		def process
			until socket.closed? || socket.eof?
				data = socket.readpartial(1024)
				parser << data
			end
		end

		def on_message_complete
			puts "parser #{parser.headers}" 
			puts "parser #{parser.http_method}" 
			puts "parser #{parser.request_url}" 
			write_response
			close			
		end

		private

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