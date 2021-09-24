# ------------------------------------------------------------------------------
# JSON TEMPLATES
# ------------------------------------------------------------------------------
# todo: this properly
# ------------------------------------------------------------------------------

# require_relative "./dirs.rb"

# ------------------------------------------------------------------------------
# CHARACTER FIGURINES
# ------------------------------------------------------------------------------
# name      char name, passed to the token
# url       png link for front and back
# imgscale  default is 1, we use 2 for smaller bases
# posX      right is positive (from dm's position)
# posZ      away is positive (from dm's position)
# scale     default 1
# rotation  rotation in degrees, 90 to face the dm
# ------------------------------------------------------------------------------

CHAR_OPEN = '{"ObjectStates":['
CHAR_ENTRY = "
{
  \"Name\": \"Figurine_Custom\",
  \"Nickname\": \"%{name}\",
  \"CustomImage\":
  {
    \"ImageURL\": \"%{url}\",
    \"ImageSecondaryURL\": \"%{url}\",
    \"ImageScalar\": %{imgscale},
  },
  \"Transform\":
  {
    \"posX\": %{posX},
    \"posY\": 0,
    \"posZ\": %{posZ},
    \"scaleX\": %{scale},
    \"scaleY\": %{scale},
    \"rotY\": %{rotation},
    \"scaleZ\": %{scale}

  },
  \"ColorDiffuse\": {
  \"r\": 1,
  \"g\": 1,
  \"b\": 1
},
\"Tags\": [
  \"%{tag}\"
],
},"
CHAR_CLOSE = ']}'

# ------------------------------------------------------------------------------
# ITEM CARD DECKS
# ------------------------------------------------------------------------------
# posX      right is positive (from dm's position)
# posZ      away is positive (from dm's position)
# rotation  rotation in degrees, 90 to face the dm
# scale     default 1
# name      Item's name, passed to the card.
# cardnum   Card identifier. Cards are inidividually identified by their CardID
#           (i.e. 2200), which is their CustomDeck number (22) appended with
#           their position on the tiled custom deck image from the top left.
#           These scripts assign a unique CustomDeck # to each card, so we don't
#           have to deal with tiling the images (or CardIDs since it's just +00)
#           and can easily pass information (i.e. the item's name) through. This
#           doesn't affect gameplay in any way, even with 100s of cards in play.
# faceurl   unique item image url
# backurl   item deck back image url
# ------------------------------------------------------------------------------

ITEM_OPEN = '{"ObjectStates":['
ITEM_ENTRY = "{
  \"Name\": \"CardCustom\",
  \"Transform\": {
  \"posX\": %{posX},
  \"posZ\": %{posZ},
  \"rotY\": %{rotation},
  \"scaleX\": %{scale},
  \"scaleY\": %{scale},
  \"scaleZ\": %{scale}
},
\"Nickname\": \"%{name}\",
\"Description\": \"\",
\"GMNotes\": \"\",
\"ColorDiffuse\": {
  \"r\": 0.713235259,
  \"g\": 0.713235259,
  \"b\": 0.713235259
},
\"Tags\": [
  \"%{tag}\"
],
\"CardID\": %{cardnum}00,
\"SidewaysCard\": false,
\"CustomDeck\": {
  \"%{cardnum}\": {
    \"FaceURL\": \"%{faceurl}\",
    \"BackURL\": \"%{backurl}\",
    \"NumWidth\": 1,
    \"NumHeight\": 1,
    \"BackIsHidden\": true,
    \"UniqueBack\": false,
    \"Type\": 0
  }
},
},"
ITEM_CLOSE = ']}'

# ------------------------------------------------------------------------------
# MAPS
# ------------------------------------------------------------------------------
# posX      right is positive (from dm's position)
# posZ      away is positive (from dm's position)
# scale     tile scale (0.99 to make sure they don't land on top of one another)
# hex       tile's hex code, gets inserted into a url to generate the texture
# backurl   underside of the tile, points to a graphic with the cardmaster logo
# ------------------------------------------------------------------------------

MAP_OPEN = '{"ObjectStates":['
MAP_ENTRY = "
{
  \"Name\": \"Custom_Tile\",
  \"Transform\": {
  \"posX\": %{posX},
  \"posY\": 0,
  \"posZ\": %{posZ},
  \"rotX\": 0,
  \"rotY\": 0,
  \"rotZ\": 0,
  \"scaleX\": %{scale},
  \"scaleY\": 1.0,
  \"scaleZ\": %{scale}
},
\"Nickname\": \"%{name}\",
\"Description\": \"%{desc}\",
\"GMNotes\": \"%{notes}\",
\"ColorDiffuse\": {
\"r\": 0.165505171,
\"g\": 0.165505171,
\"b\": 0.165505171
},
\"GridProjection\": true,
\"CustomImage\": {
\"ImageURL\":\"https://dummyimage.com/100x100/%{hex}/&text=%{text}\",\"ImageSecondaryURL\":\"%{backurl}\",
\"ImageScalar\": 1.0,
\"WidthScale\": 0.0,
\"CustomTile\": {
\"Type\": 0,
\"Thickness\": 0.1,
\"Stackable\": false,
\"Stretch\": false
}
},
\"Tags\": [
  \"%{tag}\"
],
\"LuaScript\": \"\",
\"LuaScriptState\": \"\",
\"XmlUI\": \"\"
},"
MAP_CLOSE = ']}'

# ------------------------------------------------------------------------------
# BACKGROUND PICTURES
# ------------------------------------------------------------------------------
# posX      right is positive (from dm's position)
# posZ      away is positive (from dm's position)
# rotation  rotation in degrees, 90 to face the dm
# scale     tile scale (0.99 to make sure they don't land on top of one another)
# name      name of the background image, passed to TTS
# url       location of the image on github
# ------------------------------------------------------------------------------

BG_OPEN = '{"ObjectStates":['
BG_ENTRY = "    {
\"Name\": \"Custom_Token\",
\"Transform\": {
\"posX\": %{posX},
\"posY\": 0,
\"posZ\": %{posZ},
\"rotX\": %{rotation},
\"rotY\": 0,
\"rotZ\": 0,
\"scaleX\": %{scale},
\"scaleY\": 0.1,
\"scaleZ\": %{scale}
},
\"Nickname\": \"%{name}\",
\"CustomImage\": {
\"ImageURL\": \"%{url}\",
},
\"Tags\": [
  \"%{tag}\"
],
},"
BG_CLOSE = ']}'

# ------------------------------------------------------------------------------
# STATED TOKEN OBJECTS
# ------------------------------------------------------------------------------
# rotation  rotation in degrees, 90 to face the dm
# scale     default 1
# name      object's name, passed to the token
# url       png link for front and back
# statenum  identifies unique states of the object to write to
# ------------------------------------------------------------------------------

STATED_OPEN = '{"ObjectStates":['
STATED_ENTRY_FIRST = "{
\"Name\": \"Custom_Token\",
\"Transform\": {
\"posX\": 0,
\"posY\": 0,
\"posZ\": 0,
\"rotX\": %{rotation},
\"rotY\": 0,
\"rotZ\": 0,
\"scaleX\": %{scale},
\"scaleY\": 0.1,
\"scaleZ\": %{scale}
},
\"Nickname\": \"%{name}\",
\"CustomImage\": {
\"ImageURL\": \"%{url}\",
},
\"Tags\": [
  \"%{tag}\"
],
\"LuaScript\": \"\",
\"LuaScriptState\": \"\",
\"XmlUI\": \"\",
\"States\": {"
STATED_ENTRY = "\"%{statenum}\": {
\"GUID\": \"4b8ee6\",
\"Name\": \"Custom_Token\",
\"Transform\": {
\"posX\": 0,
\"posY\": 0,
\"posZ\": 0,
\"rotX\": 0,
\"rotY\": 180,
\"rotZ\": %{rotation},
\"scaleX\": 0.98,
\"scaleY\": 0.2,
\"scaleZ\": 0.98
},
\"Nickname\": \"%{name}\",
\"Description\": \"\",
\"GMNotes\": \"\",
\"ColorDiffuse\": {
\"r\": 1.0,
\"g\": 1.0,
\"b\": 1.0
},
\"CustomImage\": {
\"ImageURL\": \"%{url}\",
\"ImageSecondaryURL\": \"\",
\"ImageScalar\": 1.0,
\"WidthScale\": 0.0,
\"CustomToken\": {
\"Thickness\": 0.2,
\"MergeDistancePixels\": 15.0,
\"StandUp\": false,
\"Stackable\": false
}
},
\"LuaScript\": \"\",
\"LuaScriptState\": \"\",
\"XmlUI\": \"\"
},"
STATED_CLOSE = '}}]}'
