require 'tts'
require 'csv'

module Tts
  module Commands
    class ImportFiles < Tts::Command
      def call(args, _name)
        tabletop_directory = ENV[Tts::TABLETOP_DIRECTORY_ENV_KEY]
        raise "You need to set the ENV key #{Tts::TABLETOP_DIRECTORY_ENV_KEY} with your tabletop saved objects folder" unless tabletop_directory

        session = Session.load!(Dir.pwd) 
        storage_adaptor = SavedObjectsStorage.new(tabletop_directory, session)

        storage_adaptor.save_files
      end

      def self.help
        "Import all tile map files in the current session directory into Tabletop Simulator.\nUsage: {{command:#{Tts::TOOL_NAME} importMap}}"
      end
    end
  end
end