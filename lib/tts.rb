require 'cli/ui'
require 'cli/kit'

CLI::UI::StdoutRouter.enable

module Tts
  extend CLI::Kit::Autocall

  TOOL_NAME = 'tts'
  ROOT      = File.expand_path('../..', __FILE__)
  LOG_FILE  = '/tmp/tts.log'

  autoload(:EntryPoint, 'tts/entry_point')
  autoload(:Commands,   'tts/commands')

  autocall(:Config)  { CLI::Kit::Config.new(tool_name: TOOL_NAME) }
  autocall(:Command) { CLI::Kit::BaseCommand }

  autocall(:Executor) { CLI::Kit::Executor.new(log_file: LOG_FILE) }
  autocall(:Resolver) do
    CLI::Kit::Resolver.new(
      tool_name: TOOL_NAME,
      command_registry: Tts::Commands::Registry
    )
  end

  autocall(:ErrorHandler) do
    CLI::Kit::ErrorHandler.new(
      log_file: LOG_FILE,
      exception_reporter: nil
    )
  end
end