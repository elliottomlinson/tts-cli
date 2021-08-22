require "open-uri"
require "addressable"

# handling variables for Tabletop Simulator
scale = 0.8
rotation = 180
rowsize = 16
bgtag="bg"

# Each char folder is a set, e.g. greenhouse-wench
Dir.mkdir(BG_SAVED_DIR) unless File.exists?(BG_SAVED_DIR)
sets = Dir.children(BG_GIT_DIR)
puts "\tfound "+sets.length.to_s+" background sets for session "+$session

sets.each do |set|
  name = Dir.children(BG_GIT_DIR+"/"+set)
  setdir = BG_SAVED_DIR+"/"+set
  posZ = posX = 0

  File.open(setdir+".json","w") do |file|
  file.write BG_OPEN
  name.each_with_index do |name,i|
    url = BG_URL % {set:set,name:name}
    url = Addressable::URI.encode(url)

    file.write BG_ENTRY % {
      name:name.chomp(".png"),
      url:url,
      posZ:posZ,
      posX:posX,
      tag:bgtag,
      scale:scale,
      rotation:rotation
      }

      # figurine rows
      if posX>(4*rowsize-8)
        posX=0
        posZ=posZ-4
      else
        posX=posX+4
      end

      # thumbnail
      if i == 0
        File.open(setdir+".png", 'wb') do |thumbnail|
          thumbnail.write URI.open(url).read
          puts "\t\tdone background set "+set
        end
      end

    end
    file.write BG_CLOSE
    file.close
  end
end
puts "\tdone all background sets for "+$session
