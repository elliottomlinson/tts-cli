require 'tts'
require 'csv'

module Tts
  module Commands
    class Import < Tts::Command
      def call(_args, _name)
        CLI::UI::StdoutRouter.enable
        CLI::UI::Frame.open('Tabletop Simulator CLI', color: :blue) do
          tabletop_directory = ENV[Tts::TABLETOP_DIRECTORY_ENV_KEY]
          unless tabletop_directory
            puts CLI::UI::fmt "{{x}} You need to set the ENV key #{Tts::TABLETOP_DIRECTORY_ENV_KEY} to point to your Tabletop Simulator saved objects folder."
            return
          else
            puts CLI::UI::fmt "{{*}} Using saved objects directory:"
            puts tabletop_directory
          end

          session = Session.load(Dir.pwd)
          if session.nil?
            puts CLI::UI::fmt "{{x}} No config.json found in the current directory."
            puts CLI::UI::fmt "{{?}} Create a session using the init command and change into the generated directory."
            return
          end

          storage_adaptor = SavedObjectsStorage.new(tabletop_directory, session)

          CLI::UI::Frame.open("Session '#{session.name}'", color: :magenta) do 
            CLI::UI::Frame.open("Character Sets", color: :cyan) do
              checklist(Tts::Importers::CharacterSets.new(session, storage_adaptor).import)
            end
            CLI::UI::Frame.open("Background Sets") do
              checklist(Tts::Importers::BackgroundSets.new(session, storage_adaptor).import)
            end
            CLI::UI::Frame.open("Item Sets") do
              checklist(Tts::Importers::ItemSets.new(session, storage_adaptor).import)
            end
            CLI::UI::Frame.open("Maps") do
              checklist(Tts::Importers::Maps.new(session, storage_adaptor).import)
            end
            CLI::UI::Frame.open("Files") do
              Tts::Importers::Files.new(session, storage_adaptor).import
              checklist(["Copied files directory"])
            end
            CLI::UI::Frame.open("Stated Tokens") do
              checklist(Tts::Importers::StatedTokens.new(session, storage_adaptor).import)
            end
            CLI::UI::Frame.open("Stated Characters") do
              checklist(Tts::Importers::StatedCharacters.new(session, storage_adaptor).import)
            end
          end
        end
      end

      def self.help
        "Import the files in the current session into your saved objects folder. \nUsage: {{command:#{Tts::TOOL_NAME} importMap}}"
      end

      private

      def checklist(items)
        items.each do |item|
          puts CLI::UI::fmt "{{v}} #{item}"
        end
      end
    end
  end
end
