status --is-interactive; or return

# Minimal tide prompt for mobile/narrow terminals.
# Triggers when ANY of: Termius client, explicit TIDE_STYLE=minimal, or narrow terminal.

function __tide_mobile_minimal --on-variable COLUMNS
    if test "$TERM_PROGRAM" = terminus \
        -o "$TIDE_STYLE" = minimal \
        -o "$COLUMNS" -lt 100
        set -g tide_left_prompt_items pwd character
        set -g tide_right_prompt_items
    end
end

__tide_mobile_minimal
