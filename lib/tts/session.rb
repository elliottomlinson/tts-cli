require "json"

module Tts
	class Session
		def initialize(path)
			@path = path
		end

		def self.load!(path)
			session = new(path)

			unless File.exists?(session.config_path)
				raise "No config file found at #{session.config_path}. Create a session with the `init` command and cd into it."
			end

		  session	
		end

		def self.build(path, name)
			repo = new(path)

			config = Templates::Config.new
			config.sessionName = name 

			FileUtils.mkdir_p(repo.map_directory_path)
			File.write(repo.config_path, config.render)
		end

		def maps
			(Dir.entries(map_directory_path) - ['.','..']).map do |entry|
				File.join(map_directory_path, entry)
			end
		end

		def config
			@config ||= JSON.parse(File.read(config_path))
		end

		def name
			config["sessionName"]
		end

		def config_path
			File.join(@path, 'config.json')
		end

		def map_directory_path
			File.join(@path, 'maps')
		end
	end
end