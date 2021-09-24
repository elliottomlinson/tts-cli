require 'tts'
require 'csv'

module Tts
  module Importers 
    class Files < BaseImporter 
      def import
        @storage_adaptor.save_files
      end
    end
  end
end