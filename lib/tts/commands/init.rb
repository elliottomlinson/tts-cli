require 'tts'

module Tts
  module Commands
    class Init < Tts::Command
      def call(args, _name)
        name = args.length == 0 ? CLI::UI.ask("Enter a name for your Session:") : args[0]

        CLI::UI::Frame.open('Tabletop Simulator CLI', color: :blue) do

          session = Session.build(name, name)

          puts CLI::UI::fmt "{{v}} Created new session directory: #{File.join(Dir.pwd, name)}"
          CLI::UI::Frame.open('Next Steps', color: :magenta) do
            puts CLI::UI::fmt "{{*}} Push the session directory to a Github repository"
            puts CLI::UI::fmt "{{*}} Copy in the base resources URL into the srcBase field in #{session.config_path}"
            puts CLI::UI::fmt "{{?}} Example srcBase: https://raw.githubusercontent.com/DuncanUszkay1/mob-city-assets/main/sandbox"
            puts CLI::UI::fmt "{{*}} Upload images and files into the session directory. Use the help command to learn more about the expected formats."
            puts CLI::UI::fmt "{{*}} Find the path to your saved objects directory in your Tabletop Simulator installation."
            puts CLI::UI::fmt "{{?}} Googling 'tabletop simulator saved objects [your operating system]' should help"
            puts CLI::UI::fmt "{{*}} Set the TABLETOP_DIRECTORY environment variable to the path from the previous step."
            puts CLI::UI::fmt "{{*}} Use the import command"
            puts CLI::UI::fmt "{{*}} Your new objects should now be accessible in Tabletop Simulator in the Saved Objects menu!"
          end
        end
      end

      def self.help
        "Initialize a new session directory. \nUsage: {{command:#{Tts::TOOL_NAME} init [session name]}}"
      end
    end
  end
end
