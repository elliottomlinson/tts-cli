module Tts
	class SavedObjectsStorage
		MAP_DIRECTORY = "maps"
		CHARACTER_DIRECTORY = "characters"
		BACKGROUND_DIRECTORY = "backgrounds"
		ITEM_DIRECTORY = "items"
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

		def save_character_set(set, set_name, set_thumbnail_path)
			character_directory_path = File.join(session_path, CHARACTER_DIRECTORY)

			FileUtils.mkdir_p(character_directory_path)
			
			character_set_file_path = File.join(character_directory_path, "#{set_name}.json")

			File.write(character_set_file_path, set)

			thumbnail_path = File.join(character_directory_path, "#{set_name}.png")

			FileUtils.cp(set_thumbnail_path, thumbnail_path)
		end

		def save_background_set(set, set_name, set_thumbnail_path)
			background_directory_path = File.join(session_path, BACKGROUND_DIRECTORY)

			FileUtils.mkdir_p(background_directory_path)
			
			background_set_file_path = File.join(background_directory_path, "#{set_name}.json")

			File.write(background_set_file_path, set)

			thumbnail_path = File.join(background_directory_path, "#{set_name}.png")

			FileUtils.cp(set_thumbnail_path, thumbnail_path)
		end

		def save_item_set(set, set_name, set_thumbnail_path)
			item_directory_path = File.join(session_path, ITEM_DIRECTORY)

			FileUtils.mkdir_p(item_directory_path)
			
			item_set_file_path = File.join(item_directory_path, "#{set_name}.json")

			File.write(item_set_file_path, set)

			thumbnail_path = File.join(item_directory_path, "#{set_name}.png")

			FileUtils.cp(set_thumbnail_path, thumbnail_path)
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
