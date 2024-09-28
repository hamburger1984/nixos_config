
pushd config; git pull; popd > /dev/null

pushd nixpkgs; git checkout master; git pull; git push my-origin; git checkout andreas_on_the_edge; git pull; git rebase master; git push -uf; popd > /dev/null

pushd plasma-manager; git pull; popd > /dev/null

pushd home-manager; git pull; popd > /dev/null

pushd hardware; git pull; popd > /dev/null

sudo nix-channel --update
#sudo nixos-rebuild -I nixpkgs=/home/andreas/Projects/nixos-related/nixpkgs switch --upgrade

sudo unbuffer nixos-rebuild -I nixpkgs=/home/andreas/Projects/nixos-related/nixpkgs switch --upgrade --log-format internal-json --verbose | nom --json
