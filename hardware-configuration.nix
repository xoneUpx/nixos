{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "usb_storage" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8c8a5dfc-aa1d-444b-b98b-b0d1e764625b";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8877-3906";
      fsType = "vfat";
    };
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/0b7f74aa-97b4-43f5-8507-6b3fed0e7ddb";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/e8addcb6-1f26-4d92-b030-f8e7151c2107"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with .
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-433fcf408d35.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-85af27830c18.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-9c64290b25e2.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-d12215cf2f6e.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  #nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
