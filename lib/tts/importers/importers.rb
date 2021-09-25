module Tts
  module Importers
    class BaseImporter
      def initialize(session, storage_adaptor)
        @session = session
        @storage_adaptor = storage_adaptor
      end
    end
  end
end

require_relative './background_sets'
require_relative './character_sets'
require_relative './stated_characters'
require_relative './stated_tokens'
require_relative './files'
require_relative './item_sets'
require_relative './maps'
