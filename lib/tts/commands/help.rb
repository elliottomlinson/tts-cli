require 'tts'

module Tts
  module Commands
    class Help < Tts::Command
      def call(_args, _name)
        puts CLI::UI.fmt('{{bold:Available commands}}')
        puts ''

        Tts::Commands::Registry.resolved_commands.each do |name, klass|
          next if name == 'help'

          puts CLI::UI.fmt("{{command:#{Tts::TOOL_NAME} #{name}}}")
          if help = klass.help
            puts CLI::UI.fmt(help)
          end
          puts ''
        end

        CLI::UI::Frame.open("Format Guide", color: :blue) do
          puts CLI::UI::fmt "This guide assumes that you're in your session directory."
          puts CLI::UI::fmt "{{?}} To create a session directory, run the init command."
          puts CLI::UI::fmt "{{*}} You can find the results of your import in the Tabletop Simulator saved objects folder under 'tts-cli/[session name]"
          CLI::UI::Frame.open("Character Sets") do
            puts CLI::UI::fmt "{{*}} For each set of character figurines, create a directory within the 'characters' directory"
            puts CLI::UI::fmt "{{*}} The name of that directory will be the name of the set."
            puts CLI::UI::fmt "{{*}} Each .png image within that directory will be turned into a figurine in that set."
            puts CLI::UI::fmt "{{*}} The name of those images (without the .png) will be used as the figurine's name"
          end
          CLI::UI::Frame.open("Background Sets") do
            puts CLI::UI::fmt "{{*}} For each set of background tokens, create a directory within the 'backgrounds' directory"
            puts CLI::UI::fmt "{{*}} The name of that directory will be the name of the set."
            puts CLI::UI::fmt "{{*}} Each .png image within that directory will be turned into a token in that set."
            puts CLI::UI::fmt "{{*}} The name of those images (without the .png) will be used as the token's name"
          end
          CLI::UI::Frame.open("Item Sets") do
            puts CLI::UI::fmt "{{*}} For each set of item cards, create a directory within the 'items' directory"
            puts CLI::UI::fmt "{{*}} The name of that directory will be the name of the set."
            puts CLI::UI::fmt "{{*}} Each .png image within that directory will be turned into a card in that set."
            puts CLI::UI::fmt "{{*}} The name of those images (without the .png) will be used as the card's name"
          end
          CLI::UI::Frame.open("Maps") do
            puts CLI::UI::fmt "{{*}} For full instructions on the Map format, see https://github.com/elliottomlinson/tts-cli#readme"
          end
          CLI::UI::Frame.open("Files") do
            puts CLI::UI::fmt "{{*}} Files in the 'files' directory will be copied as is into the saved objects folder."
          end
          CLI::UI::Frame.open("Stated Characters") do
            puts CLI::UI::fmt "{{*}} Stated characters are figurines with multiple images that can be rotated through in Tabletop Simulator."
            puts CLI::UI::fmt "{{*}} For each stated character, create a directory within the 'stated_characters' directory"
            puts CLI::UI::fmt "{{*}} The name of that directory will be the name of the figurine."
            puts CLI::UI::fmt "{{*}} Each .png image within that directory will be turned into a state of that figurine."
          end
          CLI::UI::Frame.open("Stated Tokens") do
            puts CLI::UI::fmt "{{*}} Stated tokens are figurines with multiple images that can be rotated through in Tabletop Simulator."
            puts CLI::UI::fmt "{{*}} For each stated token, create a directory within the 'stated_tokens' directory"
            puts CLI::UI::fmt "{{*}} The name of that directory will be the name of the token."
            puts CLI::UI::fmt "{{*}} Each .png image within that directory will be turned into a state of that token."
          end

        end
      end
    end
  end
end
