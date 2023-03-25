#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

  cd ~
  git clone git@github.com:dapi/dotfiles.git
  cd ~/dotfiles
  make

} # this ensures the entire script is downloaded #

