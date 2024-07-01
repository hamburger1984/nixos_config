{
  description = "NixOS Systems";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, ... }: {
    nixosConfigurations =  {

      nix2020-14 = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-l14-amd
          ./shared/boot.nix
          ./shared/console-and-fonts.nix
          ./shared/hardware.nix
          ./shared/networking.nix
          ./shared/nix.nix
          ./shared/time-and-locale.nix

          ./hosts/nix2020-10.nix

          ./shared/plasma-desktop.nix

        ];
      };

      minis-box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./shared/boot.nix
          ./shared/console-and-fonts.nix
          ./shared/hardware.nix
          ./shared/networking.nix
          ./shared/nix.nix
          ./shared/time-and-locale.nix

          ./hosts/minis-box.nix
        ];

      };
    };
  };
}
