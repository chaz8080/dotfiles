#!/bin/bash

# visit `about:config`
# set toolkit.legacyUserProfileCustomizations.stylesheets = true

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# add the css to all profiles
for d in $HOME/Library/Application\ Support/Firefox/Profiles/*/ ; do
    echo "adding chrome directory to $d"
    mkdir -p chrome
   
    echo "copying in userChrome.css"
    cp $SCRIPT_DIR/userChrome.css $d/chrome
done

echo "Firefox CSS is g2g"
echo "Don't forget to visit `about:config` and set"
echo "toolkit.legacyUserProfileCustomizations.stylesheets = true"

exit 0
