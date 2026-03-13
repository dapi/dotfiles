#!/usr/bin/env fish

# Install plugins listed in fish_plugins only when the desired set changes.
set -l plugins_file ~/.config/fish/fish_plugins
set -l desired_plugins (string match --regex '^[^\s]+$' < $plugins_file | sort)
set -l installed_plugins (fisher list | sort)
set -l desired_joined (string join \n $desired_plugins)
set -l installed_joined (string join \n $installed_plugins)

if test "$desired_joined" = "$installed_joined"
    # Lists match, but verify key function files actually exist on disk
    # (can go missing after fish-layout migrates functions/ symlink to real dir)
    if test -f ~/.config/fish/functions/tide.fish
        echo "Fisher plugins already installed"
        exit 0
    end
    echo "Fisher plugins listed but files missing, reinstalling..."
end

fisher update
