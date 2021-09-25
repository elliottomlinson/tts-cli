# Tabletop Simulator CLI

This is an opinionated command line tool for importing TTRPG assets into Tabletop Simulator.

Originally created to support games of https://github.com/elliottomlinson/cardmaster.

## Installation
This installation was tested on OSX 11.6

1. Clone this repository
2. Install ruby 2.6.3
3. Install Tabletop Simulator on Steam
4. Find your Tabletop Saved Objects directory. Example: "/Users/duncanuszkay/Library/Tabletop Simulator/Saves/Saved Objects"
5. Run the following in your terminal:
```bash
export TABLETOP_DIRECTORY="path/to/saved/objects"
TTS_CLI_PATH="/path/to/cloned/repository"
alias tts="bundle exec --gemfile=$TTS_CLI_PATH/Gemfile $TTS_CLI_PATH/exe/tts"
```
4. Run `tts help` and follow the provided instructions

## Asset Types

### Maps

Maps of colored tiles that fit on a grid. Each tile can be given a name, and a description that appears when moused over.

![Screen Shot 2021-09-24 at 10 47 07 PM](https://user-images.githubusercontent.com/8670351/134755388-85e7cd76-d864-44c6-9f16-0edfd6a2b461.png)

Map template: https://docs.google.com/spreadsheets/d/1KD_6Cewdq3Mxm0oegSlxZpCD4ZZbktvGfnAov_Gx_I8/edit#gid=1826420998

The first character in the cell dictates the color, as shown in the palette. The entire string in the cell is matched against the legend to provide the name and description.

1. Duplicate this document
2. Change the map values on one of the sheets
3. Download the sheet as a CSV
4. Place that in the session folder

### Character Sets

Groups of figurines, who are imported into the game in an organized row.

![Screen Shot 2021-09-24 at 11 05 18 PM](https://user-images.githubusercontent.com/8670351/134755849-38146d48-624d-44aa-8368-fb9670575b53.png)

### Background Sets

Cards which provide visual inspiration around the map.

![Screen Shot 2021-09-24 at 11 15 48 PM](https://user-images.githubusercontent.com/8670351/134756062-bacb3c47-de76-4df0-8536-5f7c9d4189cf.png)

### Item Sets

Cards which serve as a reference for items players can interact with in the map.

![Screen Shot 2021-09-24 at 11 41 08 PM](https://user-images.githubusercontent.com/8670351/134756613-66b5b5c5-0c62-4cb5-b888-d44c3d6a85c8.png)



