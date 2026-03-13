function rssh --wraps=ssh --description "SSH with Ghostty theme change"
    switch "$argv"
        case '*office2*'
            # Office2 - dark blue theme
            printf '\e]10;#a9b1d6\a'  # foreground (soft blue-white)
            printf '\e]11;#0d1117\a'  # background (dark navy)
            printf '\e]12;#ff9e64\a'  # cursor (orange)
        case '*'
            # Default SSH - dark purple theme
            printf '\e]10;#d3c6aa\a'  # foreground (warm light)
            printf '\e]11;#1a1225\a'  # background (dark purple)
            printf '\e]12;#e67e80\a'  # cursor (red-ish)
    end

    command ssh $argv

    # Restore Dapi theme
    printf '\e]10;#b8bb26\a'  # foreground
    printf '\e]11;#121800\a'  # background
    printf '\e]12;#02d5cf\a'  # cursor
end
