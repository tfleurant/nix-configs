# This file defines overlays
{ inputs, outputs }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    # git = prev.git.overrideAttrs (old: {
    #   version = "2.39.3";
    #   src = prev.fetchFromGitHub {
    #     owner = "NixOS";
    #     repo = "nixpkgs";
    #     rev = "8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";
    #     # If you don't know the hash, the first time, set:
    #     # hash = "";
    #     # then nix will fail the build with such an error message:
    #     # hash mismatch in fixed-output derivation '/nix/store/m1ga09c0z1a6n7rj8ky3s31dpgalsn0n-source':
    #     # specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
    #     # got:    sha256-173gxk0ymiw94glyjzjizp8bv8g72gwkjhacigd1an09jshdrjb4
    #     hash = "sha256-0gI2FHID8XYD3504kLFRLH3C2GmMCzVMC50APV/kZp8=";
    #   };
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

}
