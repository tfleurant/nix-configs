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

# Change shell
```
echo /home/tom/.nix-profile/bin/fish | sudo tee -a /etc/shells
chsh -s /home/tom/.nix-profile/bin/fish
```



# Agebox and 1password

-------------------------------
```
export NIXPKGS_ALLOW_UNFREE=1
nix develop --impure
--------------------------
op account add
eval $(op signin)
op read op://Personal/Secrets/public_key > ~/.ssh/secrets.pub
op read op://Personal/Secrets/private_key > ~/.ssh/secrets
```

Encrypt: `agebox encrypt secrets`

Decrypt: `agebox decrypt --all --force`

Remember to reencrypt before commiting