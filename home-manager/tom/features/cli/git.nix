{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Tom Fleurant";
    userEmail = "tom@flrnt";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
      core.autocrlf = "input";
      push.autoSetupRemote = true;
      index.skipHash = false;
    };
    ignores = [ ".direnv" ];
  };
}