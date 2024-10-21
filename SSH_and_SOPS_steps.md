# ssh

See: https://nixos.wiki/wiki/SSH_public_key_authentication

Generate and authorize host key
```
  # build machine
  ssh-keygen -f ~/.ssh/other-machine
  ssh-copy-id -i ~/.ssh/other-machine other-machine
```

Automatically use new key for SSH auth to other machine.
Edit ~/.ssh/config.
```
  Host other-machine
    IdentityOnly yes
    IdentityFile ~/.ssh/other-machine
```

# ssh -> age

```
  # create host age key from ssh
  nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

Copy output into 'keys' section of .sops.yaml file.


# resources

3 part series by EmergentMind (yt)

1. https://www.youtube.com/watch?v=6EMNHDOY-wo
2. https://www.youtube.com/watch?v=gdxlc5a6ne0
3. https://www.youtube.com/watch?v=HnmpYp1_aKo
