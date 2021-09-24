module Tts
	module Importers
		class BaseImporter
      def initialize(session, storage_adaptor)
        @session =session
        @storage_adaptor = storage_adaptor
      end
		end
	end
end

require_relative "./background"
require_relative "./character"
require_relative "./files"
require_relative "./item"
require_relative "./map"