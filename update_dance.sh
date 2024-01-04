
pushd config; git pull; popd

pushd nixpkgs; git checkout master; git pull; git checkout -; git rebase master; popd

pushd plasma-manager; git pull; popd
