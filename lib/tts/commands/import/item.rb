require 'tts'
require 'csv'

module Tts
  module Commands
    class ImportItems < Tts::Command
      ITEM_OBJECT_NAME = "CardCustom"
      SCALE = 0.7
      ROWSIZE = 16
      IMGSCALE = 2
      ROTATION = 0
      TAG = "item"

      def call(args, _name)
        tabletop_directory = ENV[Tts::TABLETOP_DIRECTORY_ENV_KEY]
        raise "You need to set the ENV key #{Tts::TABLETOP_DIRECTORY_ENV_KEY} with your tabletop saved objects folder" unless tabletop_directory

        session = Session.load!(Dir.pwd) 
        storage_adaptor = SavedObjectsStorage.new(tabletop_directory, session)

        if session.item_sets.length == 0
          puts "No item sets found in current session directory"
        end

        session.item_sets.each do |item_set_file_path|
          set_name = File.basename(item_set_file_path)
          puts "Importing #{set_name}..."
          image_paths = Dir.children(item_set_file_path)

          back_path = image_paths.select { |path| path == "back.png" }.first || image_paths[0]
          back_url = session.item_set_uri(set_name, back_path.chomp(".png"))

          item_object = ::Templates::Deck.new 
          item_object.object_states = image_paths.map.with_index do |image_path, card_index| 
            next unless image_path.end_with?(".png")
            item_name = image_path.chomp(".png")

            image_url = session.item_set_uri(set_name, item_name) 

            state = {
              object_name: ITEM_OBJECT_NAME,
              scale: SCALE, 
              posX: 0,
              posZ: 0,
              nickname: item_name,
              description: "",
              notes: "",
              tag: TAG, 
              face_url: image_url,
              back_url: back_url, 
              card_index: card_index + 1
            }

            state
          end.compact

          saved_object_content = item_object.render

          set_thumbnail_path = File.join(item_set_file_path, image_paths[0]) 

          storage_adaptor.save_item_set(saved_object_content, set_name, set_thumbnail_path)
        end
      end

      def self.help
        "Import all tile map files in the current session directory into Tabletop Simulator.\nUsage: {{command:#{Tts::TOOL_NAME} importMap}}"
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