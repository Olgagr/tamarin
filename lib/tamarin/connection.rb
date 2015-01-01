require 'http/parser'
require 'tamarin/response'
require 'tamarin/request'

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
			env = Request.new(parser).parse
			response = Response.new(app, socket, env)
			response.respond
			close			
		end

		private

		def close
			socket.close
		end

	end

end