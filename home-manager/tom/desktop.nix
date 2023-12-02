{ lib, pkgs, ... }:
let 
   secrets = builtins.fromTOML (builtins.readFile ../../secrets/secrets.toml);
in
{
  imports = [
    ./global
    ./features/cli/starship
    ./features/neovim
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
    };

    # shellInit = ''
    #   # ASDF with Nix
    #   set ASDF_DIR $(asdf info | grep ASDF_DIR | string split -f 2 =)
    #   source $ASDF_DIR/asdf.fish
    #   mkdir -p ~/.config/fish/completions; and ln -fs $ASDF_DIR/completions/asdf.fish ~/.config/fish/completions
    # '';

    plugins = [
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      {
        name = "asdf";
        src = pkgs.fetchFromGitHub {
          owner = "rstacruz";
          repo = "fish-asdf";
          rev = "5869c1b1ecfba63f461abd8f98cb21faf337d004";
          sha256 = "sha256-39L6UDslgIEymFsQY8klV/aluU971twRUymzRL17+6c=";
        };
      }
    ];
  };


  xdg.enable=true;
  xdg.mime.enable=true;
  targets.genericLinux.enable=true;
}
