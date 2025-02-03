#!/usr/bin/env fish

if type -q fisher 
  echo "Fisher exists"
else
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && \
    fisher install jorgebucaran/fisher
end
