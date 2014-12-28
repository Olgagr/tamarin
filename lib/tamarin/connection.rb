require 'http/parser'
require 'tamarin/statuses'

module Tamarin
	
	class Connection

		attr_accessor :socket, :parser, :app
		
		def initialize(socket, app)
			@socket = socket
			@parser = Http::Parser.new(self)
			@app = app
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
			status, headers, body = app.call

			socket.write "HTTP/1.1 #{status} #{HTTP_STATUS_CODES[status]}\r\n"
			socket.write headers.map { |k,v| "#{k}:#{v}\r\n" }.join
			socket.write "\r\n"
			socket.write "#{body.join}\n"
			body.close if body.respond_to? :close
		end

		def close
			socket.close
		end

	end

end