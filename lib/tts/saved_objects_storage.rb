module Tts
  class SavedObjectsStorage
    MAP_DIRECTORY = 'maps'
    FILE_DIRECTORY = 'files'
    CHARACTER_DIRECTORY = 'characters'
    BACKGROUND_DIRECTORY = 'backgrounds'
    ITEM_DIRECTORY = 'items'
    BASE_DIRECTORY = 'tts-cli'

    def initialize(tts_directory, session)
      @tts_directory = tts_directory
      @session = session
    end

    def save_map(map, name)
      in_saved_objects_directory(MAP_DIRECTORY) do
        File.write("#{name}.json", map)
      end
    end

    def save_character_set(set, set_name, set_thumbnail_path)
      in_saved_objects_directory(CHARACTER_DIRECTORY) do
        File.write("#{set_name}.json", set)
        FileUtils.cp(set_thumbnail_path, "#{set_name}.png")
      end
    end

    def save_background_set(set, set_name, set_thumbnail_path)
      in_saved_objects_directory(BACKGROUND_DIRECTORY) do
        File.write("#{set_name}.json", set)
        FileUtils.cp(set_thumbnail_path, "#{set_name}.png")
      end
    end

    def save_item_set(set, set_name, set_thumbnail_path)
      in_saved_objects_directory(ITEM_DIRECTORY) do
        File.write("#{set_name}.json", set)
        FileUtils.cp(set_thumbnail_path, "#{set_name}.png")
      end
    end

    def save_files
      in_saved_objects_directory(FILE_DIRECTORY) do
        FileUtils.cp_r(@session.files, '.')
      end
    end

    private

    def in_saved_objects_directory(directory, &block)
      full_path = File.join(session_path, directory)

      FileUtils.mkdir_p(full_path)
      FileUtils.rm_rf("#{full_path}/.", secure: true)

      Dir.chdir(full_path, &block)
    end

    def session_path
      File.join(base_path, @session.name)
    end

    def base_path
      File.join(@tts_directory, BASE_DIRECTORY)
    end
  end
end
