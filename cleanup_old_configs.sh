#!/bin/bash
# Cleanup script for old/limiting configurations
# This removes configs that block modern terminal features

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     Cleaning Up Old Configurations                           ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Issue 1: Remove old vim backup
if [ -f ~/.vimrc.backup ]; then
    echo "🗑️  Removing old vim backup..."
    mv ~/.vimrc.backup ~/.vimrc.backup.deleted
    echo "   ✅ Moved ~/.vimrc.backup to ~/.vimrc.backup.deleted"
fi

# Issue 2: Warn about credentials in bash_profile
if grep -q "ELASTIC_PASSWORD" ~/.bash_profile 2>/dev/null; then
    echo ""
    echo "⚠️  WARNING: Found hardcoded credentials in ~/.bash_profile"
    echo "   Line 15: ELASTIC_PASSWORD is exposed"
    echo "   Recommendation: Move credentials to environment manager or .env file"
    echo "   Creating backup: ~/.bash_profile.backup"
    cp ~/.bash_profile ~/.bash_profile.backup
fi

# Issue 3: Fix duplicate PATH in zprofile
if [ -f ~/.zprofile ]; then
    if [ "$(grep -c 'Visual Studio Code' ~/.zprofile)" -gt 1 ]; then
        echo ""
        echo "🔧 Fixing duplicate VS Code PATH entries in ~/.zprofile..."
        # Create backup
        cp ~/.zprofile ~/.zprofile.backup
        # Remove duplicates
        awk '!seen[$0]++' ~/.zprofile > ~/.zprofile.tmp && mv ~/.zprofile.tmp ~/.zprofile
        echo "   ✅ Removed duplicate entries, backup at ~/.zprofile.backup"
    fi
fi

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     Critical: Fixing Tmux Mouse Bindings                     ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "The double-click and triple-click bindings in tmux are blocking"
echo "hyperlink clicking. These will be removed from tmux.conf.symlink"
echo ""

# This will be done in a separate step
echo "✅ Cleanup preparation complete!"
echo ""
echo "Next step: Update tmux configuration to enable hyperlink clicking"
