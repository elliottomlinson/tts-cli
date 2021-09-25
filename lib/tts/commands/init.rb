require 'tts'

module Tts
  module Commands
    class Init < Tts::Command
      def call(args, _name)
        return help unless args.length == 1

        name = args[0]

        Session.build(name, name)

      end

      def self.help
        "Initialize a new session directory. \nUsage: {{command:#{Tts::TOOL_NAME} init [session name]}}"
      end
    end
  end
end
