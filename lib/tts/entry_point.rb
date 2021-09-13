require 'tts'

module Tts
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = Tts::Resolver.call(args)
      Tts::Executor.call(cmd, command_name, args)
    end
  end
end
