require 'tamarin/statuses'

module Tamarin

	class Response
		
		attr_reader :app, :socket, :env

		def initialize(app, socket, env)
			@app = app
			@socket = socket
			@env = env
		end

		def respond
			status, headers, body = app.call(env)

			socket.write "HTTP/1.1 #{status} #{HTTP_STATUS_CODES[status]}\r\n"
			socket.write headers.map { |k,v| "#{k}:#{v}\r\n" }.join
			socket.write "\r\n"
			socket.write "#{body.join}\n"
			body.close if body.respond_to? :close
		end

	end
	
end