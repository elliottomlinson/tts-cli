require 'tts'
require 'csv'

module Tts
  module Importers
    class StatedTokens < BaseImporter
      OBJECT_NAME = 'Custom_Token'
      SCALE = 1
      ROTATION = 180
      TAG = 'token'

      def import
        @session.stated_tokens.each do |stated_token_file_path|
          token_name = File.basename(stated_token_file_path)

          image_paths = Dir.children(stated_token_file_path)


          alt_states = image_paths[1..].map.with_index do |image_path, index|
            next unless image_path.end_with?('.png')

            state_name = image_path.chomp('.png')

            image_url = @session.stated_token_uri(token_name, state_name)

            {
              index: index + 1,
              name: OBJECT_NAME,
              scale: SCALE,
              posX: 0,
              posZ: 0,
              nickname: token_name,
              token: false,
              description: '',
              notes: "State: #{state_name}",
              image_url: image_url,
              back_url: image_url,
            }
          end.compact

          initial_state = image_paths[0]
          initial_state_name = initial_state.chomp('.png')
          initial_image_url = @session.stated_token_uri(token_name, initial_state_name)

          token_object = ::Templates::Base.new
          token_object.object_states = [
            {
              object_name: OBJECT_NAME,
              scale: SCALE,
              posX: 0,
              posZ: 0,
              nickname: token_name,
              description: '',
              notes: "State: #{initial_state_name}",
              tag: TAG,
              image_url: initial_image_url,
              back_url: initial_image_url,
              darken: false,
              states: alt_states
            }
          ]


          saved_object_content = token_object.render

          set_thumbnail_path = File.join(stated_token_file_path, image_paths[0])

          @storage_adaptor.save_stated_token(saved_object_content, token_name, set_thumbnail_path)
        end

        @session.stated_tokens.map do |path|
          File.basename(path)
        end
      end
    end
  end
end
