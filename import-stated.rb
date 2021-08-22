require "open-uri"
require "addressable"

# handling variables for Tabletop Simulator
rotation = 180
scale = 1
statedtag = "stated"

# Each char folder is a set, e.g. greenhouse-wench
Dir.mkdir(STATED_SAVED_DIR) unless File.exists?(STATED_SAVED_DIR)
sets = Dir.children(STATED_GIT_DIR)
puts "\tfound "+sets.length.to_s+" stated items for session "+$session

sets.each do |set|
  name = Dir.children(STATED_GIT_DIR+"/"+set)
  setdir = STATED_SAVED_DIR+"/"+set

  File.open(setdir+".json","w") do |file|
    file.write STATED_OPEN
    name.each_with_index do |name,i|
      url = STATED_URL % {set:set,name:name}
      url = Addressable::URI.encode(url)

      if i == 0
        file.write STATED_ENTRY_FIRST % {
          name:name.chomp(".png"),
          scale:scale,
          url:url,
          tag:statedtag,
          rotation:rotation
        }
        File.open(setdir+".png", 'wb') do |thumbnail|
          thumbnail.write URI.open(url).read
          thumbnail.close
        end
      elsif i > 0
        file.write STATED_ENTRY % {
          name:name.chomp(".png"),
          statenum:i+1,
          url:url,
          scale:scale,
          rotation:rotation
        }
      end
    end
    file.write STATED_CLOSE
    file.close
    puts "\t\tdone "+set.to_s
  end
end
puts "\tdone all stated items for session "+$session
