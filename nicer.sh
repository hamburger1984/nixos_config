
sudo renice -n 19 $(pgrep "make|clang|rustc|nixos-build|nixos-rebuild")
sudo ionice -c 3 -p $(pgrep "make|clang|rustc|nixos-build|nixos-rebuild")
