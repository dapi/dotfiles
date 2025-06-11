#!/usr/bin/env fish

function install
  fisher list | grep -i $argv || fisher install $argv
end

install jorgebucaran/autopair.fish
install jorgebucaran/spark.fish

#  Invalid plugin name or host unavailable: "rbenv/fish-rbenv"
# install rbenv/fish-rbenv
#
install edc/bass
install IlanCosman/tide 
install danhper/fish-ssh-agent
install halostatue/fish-direnv
