{ inputs, outputs, lib, pkgs, ... }:
{
  imports = [
    ./global
  ];

  home.packages = [pkgs.polkit]; # Not sure if this work...

  programs.git.userEmail = lib.mkForce "tfleurant@zeenea.com";
  programs.git.extraConfig.github.token = "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";
  programs.git.extraConfig.index.skipHash = false;
  programs.google-chrome.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      aws = {
        host = "i-* mi-*";
        extraOptions = {
            IdentityAgent = "~/.1password/agent.sock";
            ProxyCommand = "~/.ssh/aws-ssm-ec2-proxy-command.sh %h %r %p ~/.ssh/zeenea.pub";
            StrictHostKeyChecking="no";
        };
      };
    };
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
      orientdb-console="/opt/orientdb/orientdb-community-3.1.20/bin/console.sh";
      zeenea-cli="~/Documents/scripts/zeenea-cli.fish";
      grpc_cli="/home/tom/Documents/Projets/grpc/cmake/build/grpc_cli";
      visualvm="/opt/visualvm/visualvm_215/bin/visualvm";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "aws" "terraform" "asdf"];
      theme = "avit";
    };
    initExtra = ''
       RPROMPT="[%D{%f/%m/%y} | %D{%L:%M:%S}]"
       # ASDF with Nix
       export $(asdf info | grep ASDF_DIR)
       . $ASDF_DIR/asdf.sh;

       export SSH_AUTH_SOCK=~/.1password/agent.sock

       #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!! 
       export SDKMAN_DIR="$HOME/.sdkman"
       [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';
  };


  xdg.enable=true;
  xdg.mime.enable=true;
  targets.genericLinux.enable=true;
}