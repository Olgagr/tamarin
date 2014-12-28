module Tamarin

	class Runner

		attr_reader :app
		
		def run(app)
			@app = app
		end

		def self.parse_file(file)
			file_content = File.read(file)
			runner = new
			runner.instance_eval file_content
			runner.app
		end

	end
	
end