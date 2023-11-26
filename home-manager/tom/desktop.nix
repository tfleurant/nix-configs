{ lib, pkgs, ... }:
let 
   secrets = builtins.fromTOML (builtins.readFile ../../secrets/secrets.toml);
in
{
  imports = [
    ./global
    ./features/cli/starship
  ];

  programs.ssh = {
    enable = true;
  };

  programs.vscode.enable = true;
  programs.bash.enable = true;

  programs.fish = {
    # To use, add /home/tom/.nix-profile/bin/fish to /etc/shells and then run chsh -s $(which zsh) tom
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
