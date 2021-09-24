require 'tts'
require 'csv'

module Tts
  module Commands
    class Import < Tts::Command
      def call(args, _name)
        tabletop_directory = ENV[Tts::TABLETOP_DIRECTORY_ENV_KEY]
        raise "You need to set the ENV key #{Tts::TABLETOP_DIRECTORY_ENV_KEY} with your tabletop saved objects folder" unless tabletop_directory

        session = Session.load!(Dir.pwd) 
        storage_adaptor = SavedObjectsStorage.new(tabletop_directory, session)

        Tts::Importers::CharacterSets.new(session, storage_adaptor).import
        Tts::Importers::BackgroundSets.new(session, storage_adaptor).import
        Tts::Importers::ItemSets.new(session, storage_adaptor).import
        Tts::Importers::Maps.new(session, storage_adaptor).import
        Tts::Importers::Files.new(session, storage_adaptor).import
      end

      def self.help
        "Import the files in the current session into your saved objects folder. \nUsage: {{command:#{Tts::TOOL_NAME} importMap}}"
      end
    end
  end
end