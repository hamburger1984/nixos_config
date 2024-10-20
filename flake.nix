{
  description = "NixOS Systems";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Declarative partitioning and formatting
    #disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, ... }: {
    nixosConfigurations =  {

      # Laptop
      nix2020-14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-l14-amd
          ./shared/boot.nix
          ./shared/console-and-fonts.nix
          ./shared/hardware.nix
          ./shared/networking.nix
          ./shared/nix.nix
          ./shared/time-and-locale.nix
          ./shared/zsh.nix
          ./shared/packages.nix
          ./shared/services.nix

          ./hosts/nix2020-14.nix

          ./shared/andreas.nix

          ./shared/plasma-desktop.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andreas = import ./home-manager/configuration.nix;
          }
        ];
      };

      # Box 1
      brick-2023 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./shared/boot.nix
          ./shared/console-and-fonts.nix
          ./shared/hardware.nix
          ./shared/networking.nix
          ./shared/nix.nix
          ./shared/time-and-locale.nix
          ./shared/zsh.nix
          ./shared/packages.nix
          ./shared/services.nix

          ./hosts/brick-2023.nix

          ./shared/andreas.nix

          ./shared/plasma-desktop.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andreas = import ./home-manager/configuration.nix;
          }
        ];
      };

      # Box 2
      minis-box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./shared/boot.nix
          ./shared/console-and-fonts.nix
          ./shared/hardware.nix
          ./shared/networking.nix
          ./shared/nix.nix
          ./shared/time-and-locale.nix
          ./shared/andreas.nix
          ./shared/zsh.nix
          ./shared/packages.nix
          ./shared/services.nix

          ./hosts/minis-box.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andreas = import ./home-manager/configuration-headless.nix;
          }
        ];

      };
    };
  };
}
