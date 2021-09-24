require 'tts'
require 'csv'

module Tts
  module Importers 
    class Maps < BaseImporter 
      TILE_URL_TEMPLATE = "https://dummyimage.com/100x100/%{hex}/&text=%{text}"
      TILE_BACK_URL = "https://raw.githubusercontent.com/elliottomlinson/tts-cli/master/res/tile/back.png"
      TILE_OBJECT_NAME = "Custom_Tile"
      SCALE = 0.99
      MAP_TAG = "map"
      MAGIC_EMPTY_TEXT = "%99"

      def import 
        @session.maps.each do |map_file_path|
          puts "Importing #{map_file_path}..."
          map_name = File.basename(map_file_path).chomp(".csv")

          map = Map.from_csv(map_file_path)

          map_object = ::Templates::Base.new 
          map_object.object_states = map.tiles.map.with_index do |tile_row, row_index|
            tile_row.map.with_index do |tile, column_index|
              next if tile.nil?

              {
                object_name: TILE_OBJECT_NAME,
                scale: SCALE, 
                posX: x_position(column_index),
                posZ: z_position(row_index),
                nickname: tile.name,
                description: tile.description || "",
                notes: tile.notes || "",
                tag: MAP_TAG, 
                image_url: TILE_URL_TEMPLATE % { hex: tile.color[1..], text: MAGIC_EMPTY_TEXT },
                back_url: TILE_BACK_URL,
                darken: true 
              }
            end.compact
          end.flatten

          saved_object_content = map_object.render

          @storage_adaptor.save_map(saved_object_content, map_name)
        end
      end

      private

      def x_position(column_index)
        column_index * 2
      end

      def z_position(row_index)
        row_index * -2
      end
    end
  end
end

class Map 
  MAP_WIDTH = MAP_HEIGHT = 60
  FLAVOUR_ROW_START = 6
  FLAVOUR_COLUMN_START = MAP_WIDTH + 2
  FLAVOUR_COLUMN_END = MAP_WIDTH + 5 

  def self.from_csv(map_path)
    Map.new(CSV.read(map_path))
  end

  def initialize(raw_map_values)
    @raw_map_values = raw_map_values
  end

  def tiles
    @tiles ||= process_tiles(extract_section(1,MAP_WIDTH,1,MAP_HEIGHT))
  end

  private

  def extract_section(first_column, last_column, first_row, last_row) 
    rows = if last_row.nil?
      @raw_map_values[first_row-1..]
    else
      @raw_map_values[first_row-1..last_row-1]
    end

    rows.map do |row|
      if last_column.nil?
        row[first_column-1..]
      else
        row[first_column-1..last_column-1]
      end
    end
  end

  def process_tiles(section)
    section.map do |row|
      row.map do |tile|
        if tile == "0"
          # We don't place the black empty space tiles due to a physics issue in Tabletop Simulator
          nil
        else
          color_code = colors[tile[0]]
          flavour_info = flavour[tile]
          if flavour_info.nil?
            Tile.new(color_code)
          else
            Tile.new(color_code, flavour_info[:name], flavour_info[:description], flavour_info[:notes])
          end
        end
      end
    end
  end

  def colors 
    @color ||= process_colors(extract_section(1, MAP_WIDTH, MAP_HEIGHT+1, nil))
  end

  def flavour 
    @flavour ||= process_flavour(extract_section(FLAVOUR_COLUMN_START, FLAVOUR_COLUMN_END, FLAVOUR_ROW_START, nil))
  end

  def process_colors(section)
    color_dict = {}

    section.each do |row|
      row.each_with_index do |entry, i|
        # Identify a new label that isn't an empty cell or a hexcode
        unless entry.nil? || entry.start_with?("#") || entry == ""
          color_dict[entry] = row[i+1]
        end
      end
    end

    color_dict
  end

  def process_flavour(section)
    flavour_dict = {}

    section.each do |row|
      symbol = row[0]
      unless symbol == ""
        name = row[1]
        description = row[2]
        notes = row[3]
        flavour_dict[symbol] = { name: name, description: description, notes: notes }
      end
    end

    flavour_dict
  end

end

class Tile
  attr_reader :color, :name, :description, :notes
  def initialize(color, name=nil, description=nil, notes=nil)
    @color = color
    @name = name
    @description = description
    @notes = notes
  end
end