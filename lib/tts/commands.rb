require 'tts'
require_relative '../templates/templates.rb'
require_relative './session.rb'
require_relative './saved_objects_storage.rb'

module Tts
  TABLETOP_DIRECTORY_ENV_KEY = "TABLETOP_DIRECTORY"

  module Commands
    Registry = CLI::Kit::CommandRegistry.new(
      default: 'help',
      contextual_resolver: nil
    )

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :ImportItems, 'importItems', 'tts/commands/import/item'
    register :ImportBackgrounds, 'importBackgrounds', 'tts/commands/import/background'
    register :ImportCharacters, 'importCharacters', 'tts/commands/import/character'
    register :ImportMaps, 'importMaps', 'tts/commands/import/map'
    register :Init, 'init', 'tts/commands/init'
    register :Help,    'help',    'tts/commands/help'
  end
end
