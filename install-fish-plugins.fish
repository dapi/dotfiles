#!/usr/bin/env fish

function install
  fisher list | grep -i $argv || fisher install $argv
end

install jorgebucaran/autopair.fish
install jorgebucaran/spark.fish
install rbenv/fish-rbenv
install jorgebucaran/nvm.fish
install IlanCosman/tide 
install danhper/fish-ssh-agent
install halostatue/fish-direnv
