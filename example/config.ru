class App

	def call
		[
			200,
			{ 'Content-Type' => 'text/plain' },
			['This is a message from rack app']
		]
	end
	
end

run App.new