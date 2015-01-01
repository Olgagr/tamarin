require 'stringio'

module Tamarin

	class Request

		attr_accessor :parser
		
		def initialize(parser)
			@parser = parser
		end

		def parse
			env = {}
			parser.headers.each do |k, v|
				key = "HTTP_#{k.upcase.tr('-', '_')}"
				env[key] = v
			end
			env['PATH_INFO'] = parser.request_url
			env['REQUEST_METHOD'] = parser.http_method
			env['rack.input'] = StringIO.new

			env
		end

	end
	
end