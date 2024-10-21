{ config, inputs, lib, modulesPath, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  sops = {
    defaultSopsFile = ../secrets.yaml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    secrets = {
      nextcloud.

    };
  };

  networking.hostName = "minis-box"; # Define your hostname.

  system.stateVersion = "23.11"; # Did you read the comment?

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/149edd66-95a6-4b77-9d18-74aab080d621";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/99FD-8148";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  #services.nginx.enable = true;
  #services.nginx.virtualHosts.minis-box = {
  #  extraConfig = ''
  #    ## Per https://immich.app/docs/administration/reverse-proxy...
  #    client_max_body_size 50000M;
  #  '';
  #  forceSSL = true;
  #  enableACME = true;
  #  locations."/" = {
  #    proxyPass = "http://127.0.0.1:2283";
  #    proxyWebsockets = true;
  #  };
  #};

  security.acme = {
    acceptTerms = true;
    defaults.email = "hamburger1984@gmail.com";
  };

  # === immich ===
  services.immich = {
    enable = true;
    port = 2283;
    environment.IMMICH_MACHINE_LEARNING_URL = "http://localhost:3003";
  };
  users.users.immich.extraGroups = [ "video" "render" ];

  # === nextcloud ===
  services.nextcloud = {
    enable = true;
  };
}
