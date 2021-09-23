require 'tts'

module Tts
  module Commands
    class Init < Tts::Command
			def call(args, _name)
				return self.help unless args.length == 1
				name = args[0]

				Session.build(name, name)

				puts "Created session in #{name}. Change into the session directory to use import commands."
			end

			def self.help
				"Initialize a new session directory. \nUsage: {{command:#{Tts::TOOL_NAME} init [session name]}}"
			end
		end
	end
end