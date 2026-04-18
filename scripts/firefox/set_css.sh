#!/bin/bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROFILES_DIR="$HOME/Library/Application Support/Firefox/Profiles"

if [ ! -d "$PROFILES_DIR" ]; then
    echo "⚠ Firefox profiles directory not found — skipping"
    echo "  Run this again after launching Firefox at least once."
    exit 0
fi

for d in "$PROFILES_DIR"/*/ ; do
    echo "→ Profile: $(basename "$d")"

    # Deploy userChrome.css
    mkdir -p "$d/chrome"
    cp -f "$SCRIPT_DIR/userChrome.css" "$d/chrome"
    echo "  ✓ userChrome.css deployed"

    # Deploy user.js to auto-enable custom stylesheets
    cp -f "$SCRIPT_DIR/user.js" "$d/user.js"
    echo "  ✓ user.js deployed (enables toolkit.legacyUserProfileCustomizations.stylesheets)"
done

echo ""
echo "✓ Firefox CSS setup complete"
echo ""
echo "Manual steps remaining (one-time per fresh install):"
echo "  1. Install extensions — see scripts/firefox/README.md"
echo "  2. Open Tree Style Tab preferences → Advanced → Extra style rules"
echo "     Paste contents of: scripts/firefox/treestyletab.css"

exit 0
