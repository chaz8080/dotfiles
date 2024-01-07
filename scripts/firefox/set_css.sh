#!/bin/bash

# visit `about:config`
# set toolkit.legacyUserProfileCustomizations.stylesheets = true

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# add the css to all profiles
for d in $HOME/Library/Application\ Support/Firefox/Profiles/*/ ; do
    echo "creating chrome directory if it doesn't exist: $d"
    mkdir -p chrome
   
    echo "copying userChrome.css"
    cp $SCRIPT_DIR/userChrome.css $d/chrome
done

echo "firefox css is g2g"
echo "don't forget to visit about:config and set"
echo "toolkit.legacyUserProfileCustomizations.stylesheets = true"
echo "visit about:addons and load the treestyletab.css to remove the + icon for new tabs"

exit 0
