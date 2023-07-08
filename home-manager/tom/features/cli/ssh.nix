{ outputs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      identity1password = {
        host = "*";
        extraOptions = {
            IdentityAgent = "~/.1password/agent.sock";
        };
      };
    };
  };
}