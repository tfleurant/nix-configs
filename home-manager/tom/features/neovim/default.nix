{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  xdg.configFile."nvim" ={
    source = ./nvim;
    recursive = true;
  };
}