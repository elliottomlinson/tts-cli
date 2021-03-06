require 'json'

module Tts
  class Session
    def initialize(path)
      @path = path
    end

    def self.load(path)
      session = new(path)

      return unless File.exist?(session.config_path)

      session
    end

    def self.build(path, name)
      session = new(path)

      config = Templates::Config.new
      config.sessionName = name

      FileUtils.mkdir_p(session.map_directory_path)
      FileUtils.mkdir_p(session.background_set_directory_path)
      FileUtils.mkdir_p(session.character_set_directory_path)
      FileUtils.mkdir_p(session.item_set_directory_path)
      FileUtils.mkdir_p(session.stated_token_directory_path)
      FileUtils.mkdir_p(session.stated_character_directory_path)
      File.write(session.config_path, config.render)

      session
    end

    def maps
      (Dir.entries(map_directory_path) - ['.', '..']).map do |entry|
        File.join(map_directory_path, entry)
      end
    end

    def character_sets
      (Dir.children(character_set_directory_path) - ['.', '..']).map do |entry|
        File.join(character_set_directory_path, entry)
      end.select do |path|
        File.directory?(path)
      end
    end

    def stated_tokens
      (Dir.children(stated_token_directory_path) - ['.', '..']).map do |entry|
        File.join(stated_token_directory_path, entry)
      end.select do |path|
        File.directory?(path)
      end
    end

    def stated_characters
      (Dir.children(stated_character_directory_path) - ['.', '..']).map do |entry|
        File.join(stated_character_directory_path, entry)
      end.select do |path|
        File.directory?(path)
      end
    end

    def background_sets
      (Dir.children(background_set_directory_path) - ['.', '..']).map do |entry|
        File.join(background_set_directory_path, entry)
      end.select do |path|
        File.directory?(path)
      end
    end

    def item_sets
      (Dir.children(item_set_directory_path) - ['.', '..']).map do |entry|
        File.join(item_set_directory_path, entry)
      end.select do |path|
        File.directory?(path)
      end
    end

    def files
      (Dir.children(files_path) - ['.', '..']).map do |entry|
        File.join(files_path, entry)
      end
    end

    def config
      @config ||= JSON.parse(File.read(config_path))
    end

    def name
      config['sessionName']
    end

    def srcBase
      srcBase = config['srcBase']
      if srcBase.nil?
        raise 'Set srcBase in config.json to be your github repository URL including the path to the folder. E.G. https://raw.githubusercontent.com/elliottomlinson/cardmaster/master/sessions/mySession'
      end

      srcBase.end_with?('/') ? srcBase : "#{srcBase}/"
    end

    def character_set_uri(set_name, character_name)
      File.join(srcBase, '/characters/', "/#{set_name}/", "#{character_name}.png")
    end

    def stated_token_uri(token_name, state_name)
      File.join(srcBase, '/stated_tokens/', "/#{token_name}/", "#{state_name}.png")
    end

    def stated_character_uri(character_name, state_name)
      File.join(srcBase, '/stated_characters/', "/#{character_name}/", "#{state_name}.png")
    end

    def background_set_uri(set_name, background_name)
      File.join(srcBase, '/backgrounds/', "/#{set_name}/", "#{background_name}.png")
    end

    def item_set_uri(set_name, item_name)
      File.join(srcBase, '/items/', "/#{set_name}/", "#{item_name}.png")
    end

    def config_path
      File.join(@path, 'config.json')
    end

    def map_directory_path
      File.join(@path, 'maps')
    end

    def character_set_directory_path
      File.join(@path, 'characters')
    end

    def background_set_directory_path
      File.join(@path, 'backgrounds')
    end

    def item_set_directory_path
      File.join(@path, 'items')
    end

    def stated_token_directory_path
      File.join(@path, 'stated_tokens')
    end

    def stated_character_directory_path
      File.join(@path, 'stated_characters')
    end

    def files_path
      File.join(@path, 'files')
    end
  end
end
