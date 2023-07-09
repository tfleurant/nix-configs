{ inputs, outputs, lib, pkgs, ... }:
{
  imports = [
    ./global
  ];

  home.packages = [pkgs.polkit]; # Not sure if this work...

  programs.git.userEmail = lib.mkForce "tom@flrnt.fr";
  
  programs.vscode.enable = true;
  programs.vscode.userSettings = {
    "files.autoSave" = "on";
  };

  programs.zsh = {
    # To use, add /home/tom/.nix-profile/bin/zsh to /etc/shells and then run chsh -s $(which zsh) tom
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = false;
    enableCompletion = true;
    shellAliases = {
      weather="curl wttr.in/Nantes";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "asdf"];
      theme = "avit";
    };
    initExtra = ''
       RPROMPT="[%D{%f/%m/%y} | %D{%L:%M:%S}]"
       # ASDF with Nix
       export $(asdf info | grep ASDF_DIR)
       . $ASDF_DIR/asdf.sh;

       export SSH_AUTH_SOCK=~/.1password/agent.sock
    '';
  };


  # xdg.enable=true;
  # xdg.mime.enable=true;
  # targets.genericLinux.enable=true;
}
