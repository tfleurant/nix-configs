# My nix configs

Initialised from https://github.com/Misterio77/nix-starter-configs

# nixos-init.sh

In term (not GUI):
```sh
sudo loadkeys fr
nix-shell -p git
git clone https://github.com/tfleurant/nix-configs /tmp/nix-configs && cd /tmp/nix-configs
chmod +x ./nixos-init.sh
```

After booting, run the `passwd` command to change your password.