{ lib, pkgs, ... }:
let 
   secrets = builtins.fromTOML (builtins.readFile ../../secrets/secrets.toml);
in
{
  imports = [
    ./global
    ./features/cli/starship
  ];

  home.packages = [pkgs.polkit]; # Not sure if this work...

  programs.git = {
    userEmail = lib.mkForce secrets.git.work.email;
    extraConfig.github.token = lib.mkForce secrets.git.work.githubToken;
    extraConfig.index.skipHash = false;
  };

  home.file = {
    ".gradle/gradle.properties".text = ''
      github.actor=${secrets.git.work.email}
      github.token=${secrets.git.work.githubToken}
    '';

    ".sbt/credentials".text = ''
      realm=default
      host=repo.deps.co
      user=${secrets.sbt.work.credentials.user}
      password=${secrets.sbt.work.credentials.password}
    '';

    ".npmrc".text = ''
      always-auth=true
      ${secrets.npm.work.registry}
      //npm.pkg.github.com/:_authToken=${secrets.git.work.githubToken}
    '';
  };


  programs.google-chrome.enable = true;

  programs.vscode.package = pkgs.unstable.vscode;
  programs.vscode.enable = true;
  programs.vscode.userSettings = {
    "files.autoSave" = "on";
  };


  programs.ssh = {
    enable = true;
    matchBlocks = {
      aws = {
        host = "i-* mi-*";
        extraOptions = {
            ProxyCommand = "bash -c \"~/.ssh/aws-ssm-ec2-proxy-command.sh %h %r %p ~/.ssh/zeenea.pub\"";
            StrictHostKeyChecking="no";
        };
      };
      github = {
        host = "github.com/zeenea";
        identityFile = "~/.ssh/work";
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
    '';
  };


  xdg.enable=true;
  xdg.mime.enable=true;
  targets.genericLinux.enable=true;
}