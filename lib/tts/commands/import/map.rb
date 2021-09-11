require 'tts'

module Tts
  module Commands
    class ImportMap < Tts::Command
      def call(_args, _name)
      end

      def self.help
        "A dummy command.\nUsage: {{command:#{Tts::TOOL_NAME} example}}"
      end
    end
  end
end
