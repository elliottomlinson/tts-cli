require 'tts'
require 'csv'

module Tts
  module Importers
    class StatedCharacters < BaseImporter
      OBJECT_NAME = 'Figurine_Custom'
      SCALE = 0.7
      ROTATION = 0
      TAG = 'char'

      def import

        @session.stated_characters.each do |stated_character_file_path|
          character_name = File.basename(stated_character_file_path)

          image_paths = Dir.children(stated_character_file_path)

          alt_states = image_paths[1..].map.with_index do |image_path, index|
            next unless image_path.end_with?('.png')

            state_name = image_path.chomp('.png')

            image_url = @session.stated_character_uri(character_name, state_name)

            {
              index: index + 1,
              name: OBJECT_NAME,
              scale: SCALE,
              posX: 0,
              posZ: 0,
              nickname: character_name,
              character: false,
              description: '',
              notes: "State: #{state_name}",
              image_url: image_url,
              back_url: image_url,
            }
          end.compact

          initial_state = image_paths[0]
          initial_state_name = initial_state.chomp('.png')
          initial_image_url = @session.stated_character_uri(character_name, initial_state_name)

          character_object = ::Templates::Base.new
          character_object.object_states = [
            {
              object_name: OBJECT_NAME,
              scale: SCALE,
              posX: 0,
              posZ: 0,
              nickname: character_name,
              description: '',
              notes: "State: #{initial_state_name}",
              tag: TAG,
              image_url: initial_image_url,
              back_url: initial_image_url,
              darken: false,
              states: alt_states
            }
          ]


          saved_object_content = character_object.render

          puts saved_object_content

          set_thumbnail_path = File.join(stated_character_file_path, image_paths[0])

          @storage_adaptor.save_stated_character(saved_object_content, character_name, set_thumbnail_path)
        end
      end
    end
  end
end
