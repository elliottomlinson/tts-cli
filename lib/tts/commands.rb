require 'tts'
require 'bundler/setup'
require_relative '../templates/templates.rb'

module Tts
  TABLETOP_DIRECTORY_ENV_KEY = "TABLETOP_DIRECTORY"
  SAVED_OBJECTS_DIRECTORY = "tts-cli"

  module Commands
    Registry = CLI::Kit::CommandRegistry.new(
      default: 'help',
      contextual_resolver: nil
    )

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :ImportMap, 'importMap', 'tts/commands/import/map'
    register :Help,    'help',    'tts/commands/help'
  end
end
