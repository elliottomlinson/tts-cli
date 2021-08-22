require_relative "./templates.rb"
require_relative "./dirs.rb"
require 'fileutils'

FileUtils.copy_entry MISC_GIT_DIR, MISC_SAVED_DIR

puts "done all misc. items"
