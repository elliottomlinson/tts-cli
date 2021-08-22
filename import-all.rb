require_relative "./config.rb"
require 'bundler/setup'
$VERBOSE = nil
SESSIONS_GIT_DIR = GIT_DIR+"/assets/campaign"

$session = ''

load "./templates.rb"

sessions = Dir.children(SESSIONS_GIT_DIR)
puts "begin Cardmaster asset import"
puts "found "+sessions.length.to_s+" sessions"
puts ""

sessions.each do |eachsession|
  $session = eachsession

  puts "processing session "+eachsession
  load "./dirs.rb"
  Dir.mkdir(SESSION_SAVED_DIR) unless File.exists?(SESSION_SAVED_DIR)

  load "./templates.rb"
  load "./import-map.rb"
  load "./import-char.rb"
  load "./import-bg.rb"
  load "./import-item.rb"
  load "./import-stated.rb"
  puts "done session "+eachsession
  puts ""

end
  load "./import-tts-objs.rb"
puts "all done"
#  require_relative "./import-bg.rb"
#  require_relative "./import-char.rb"
#  require_relative "./import-item.rb"
#  require_relative "./import-map.rb"
#  require_relative "./import-stated.rb"
#  require_relative "./import-tts-objs.rb"
