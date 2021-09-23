module Tts
	class SessionRepository
		def initialize(path)
			@path = path
		end

		def self.load_session!(path)
			repo = new(path)

			unless File.exists?(repo.config_path)
				raise "No config file found at #{repo.config_path}. Create a session with the `init` command and cd into it."
			end

		  repo	
		end

		def self.create_session(path, name)
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

		def config_path
			File.join(@path, 'config.json')
		end

		def map_directory_path
			File.join(@path, 'maps')
		end

		private

	end
end