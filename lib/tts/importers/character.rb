require 'tts'
require 'csv'

module Tts
  module Importers
    class CharacterSets < BaseImporter
      CHARACTER_OBJECT_NAME = "Figurine_Custom"
      SCALE = 0.7
      ROWSIZE = 16
      IMGSCALE = 2
      ROTATION = 0
      TAG = "char"

      def import
        @session.character_sets.each do |character_set_file_path|
          set_name = File.basename(character_set_file_path)

          row_index = 0
          column_index = 0

          image_paths = Dir.children(character_set_file_path)

          character_object = ::Templates::Base.new 
          character_object.object_states = image_paths.map do |image_path| 
            next unless image_path.end_with?(".png")
            character_name = image_path.chomp(".png")

            image_url = @session.character_set_uri(set_name, character_name) 

            state = {
              object_name: CHARACTER_OBJECT_NAME,
              scale: SCALE, 
              posX: x_position(row_index),
              posZ: z_position(column_index),
              nickname: character_name,
              description: "",
              notes: "",
              tag: TAG, 
              image_url: image_url,
              back_url: image_url,
              darken: false 
            }

            row_index, column_index = next_available_position(row_index, column_index)

            state
          end.compact

          saved_object_content = character_object.render

          set_thumbnail_path = File.join(character_set_file_path, image_paths[0]) 

          @storage_adaptor.save_character_set(saved_object_content, set_name, set_thumbnail_path)
        end
      end

      private

      def next_available_position(row_index, column_index)
        if row_index < ROWSIZE
          [row_index+1, column_index]
        else
          [0, column_index+1]
        end
      end

      def x_position(column_index)
        column_index * 2
      end

      def z_position(row_index)
        row_index * -2
      end
    end
  end
end