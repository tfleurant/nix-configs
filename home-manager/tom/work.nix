{ inputs, outputs, lib, pkgs, ... }:
{
  imports = [
    ./global
    ./features/cli/starship
  ];

  home.packages = [pkgs.polkit]; # Not sure if this work...

  programs.git.userEmail = lib.mkForce "TODO";
  programs.git.extraConfig.github.token = "TODO";
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
      enable = false;
      plugins = [ "git" "aws" "terraform" "asdf"];
      theme = "avit";
    };
    initExtra = ''
       # ASDF with Nix
       export $(asdf info | grep ASDF_DIR)
       . $ASDF_DIR/asdf.sh;

       export SSH_AUTH_SOCK=~/.1password/agent.sock

       #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!! 
       export SDKMAN_DIR="$HOME/.sdkman"
       [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      weather="curl wttr.in/Nantes";
      orientdb-console="/opt/orientdb/orientdb-community-3.1.20/bin/console.sh";
      zeenea-cli="~/Documents/scripts/zeenea-cli.fish";
      grpc_cli="/home/tom/Documents/Projets/grpc/cmake/build/grpc_cli";
      visualvm="/opt/visualvm/visualvm_215/bin/visualvm";
    };

    shellInit = ''
      # ASDF with Nix
      set ASDF_DIR $(asdf info | grep ASDF_DIR | string split -f 2 =)
      source $ASDF_DIR/asdf.fish
      mkdir -p ~/.config/fish/completions; and ln -fs $ASDF_DIR/completions/asdf.fish ~/.config/fish/completions

      export SSH_AUTH_SOCK=~/.1password/agent.sock
    '';
  };


  xdg.enable=true;
  xdg.mime.enable=true;
  targets.genericLinux.enable=true;
}