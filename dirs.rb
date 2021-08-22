require_relative "./config.rb"

SESSION_SAVED_DIR = SAVED_OBJ_DIR+"/"+$session
SESSION_GIT_DIR = GIT_DIR+"/assets/campaign/"+$session
RAWURL = "https://raw.githubusercontent.com/elliottomlinson/rpcg/master/assets/campaign/"+$session+"/"

# figurine import
CHAR_GIT_DIR = SESSION_GIT_DIR+"/char"
CHAR_SAVED_DIR = SESSION_SAVED_DIR+"/char"
CHAR_URL = RAWURL+"char/%{set}/%{name}"

# item import
ITEM_GIT_DIR = SESSION_GIT_DIR+"/item"
ITEM_SAVED_DIR = SESSION_SAVED_DIR+"/item"
ITEM_FACE_URL = RAWURL+"/item/%{set}/%{name}"
ITEM_BACK_URL = RAWURL+"/item/back/%{set}.png"

# map import
MAP_GIT_DIR = SESSION_GIT_DIR+"/map/"
MAP_SAVED_DIR = SESSION_SAVED_DIR+"/map"

# bg import
BG_GIT_DIR = SESSION_GIT_DIR+"/bg"
BG_SAVED_DIR = SESSION_SAVED_DIR+"/bg"
BG_URL = RAWURL+"bg/%{set}/%{name}"

# stated import
STATED_GIT_DIR = SESSION_GIT_DIR+"/stated"
STATED_SAVED_DIR = SESSION_SAVED_DIR+"/stated"
STATED_URL = RAWURL+"/stated/%{set}/%{name}"

# other import
MISC_GIT_DIR = GIT_DIR+"/assets/core/obj"
MISC_SAVED_DIR = SAVED_OBJ_DIR+"/Cardmaster Misc."
