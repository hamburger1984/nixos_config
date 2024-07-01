{ config, lib, pkgs, ...}:
{
    nixpkgs.config.allowUnfree = true;

    nix = {
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 3d";
        };
    };

    settings = {
        auto-optimize-store = true;
        max-jobs = 15; # keep one spare core
        trusted-users = [ "andreas" ];
        experimental-features = [ "nix-command" "flakes" ];
    };
}
