module Tts
	class SavedObjectsStorage
		MAP_DIRECTORY = "maps"
		BASE_DIRECTORY = "tts-cli"

		def initialize(tts_directory, session)
			@tts_directory = tts_directory
			@session = session
		end

		def save_map(map, name)
			map_directory_path = File.join(session_path, MAP_DIRECTORY)

			FileUtils.mkdir_p(map_directory_path)
			
			map_file_path = File.join(map_directory_path, "#{name}.json")

			File.write(map_file_path, map)
		end

		private

		def session_path
			File.join(base_path, @session.name)
		end

		def base_path
			File.join(@tts_directory, BASE_DIRECTORY)
		end
	end
end
