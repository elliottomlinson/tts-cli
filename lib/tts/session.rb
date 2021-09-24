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
			FileUtils.mkdir_p(repo.character_set_directory_path)
			File.write(repo.config_path, config.render)
		end

		def maps
			(Dir.entries(map_directory_path) - ['.','..']).map do |entry|
				File.join(map_directory_path, entry)
			end
		end

		def character_sets
			(Dir.children(character_set_directory_path) - ['.','..']).map do |entry|
				File.join(character_set_directory_path, entry)
			end.select do |path|
				File.directory?(path)
			end
		end

		def config
			@config ||= JSON.parse(File.read(config_path))
		end

		def name
			config["sessionName"]
		end

		def srcBase
			srcBase = config["srcBase"]
			if srcBase.nil?
				raise "Set srcBase in config.json to be your github repository URL including the path to the folder. E.G. https://raw.githubusercontent.com/elliottomlinson/cardmaster/master/sessions/mySession" 
			end
			srcBase.end_with?("/") ? srcBase : "#{srcBase}/"
		end

		def character_set_uri(set_name, character_name)
			puts File.join(srcBase, "/characters/", "/#{set_name}/", "#{character_name}.png")
			File.join(srcBase, "/characters/", "/#{set_name}/", "#{character_name}.png")
		end

		def config_path
			File.join(@path, 'config.json')
		end

		def map_directory_path
			File.join(@path, 'maps')
		end

		def character_set_directory_path
			File.join(@path, 'characters')
		end
	end
end