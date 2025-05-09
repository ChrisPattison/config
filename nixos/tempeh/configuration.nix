{ config, pkgs, lib,  ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = false;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = true;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Fn key shenanigans for Keychron K3
  # From https://github.com/tim-hilt/nixos/blob/main/config/desktop.nix
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  boot.kernelModules = [ "hid-apple" ];
  
  # Set up networking
  networking = {
    hostName = "tempeh";
    nameservers = [
      "131.215.9.49"
      "131.215.139.100"
      "131.215.254.100"
    ];
    defaultGateway = "131.215.104.254";
    interfaces.enp2s0.ipv4 = {
      addresses = [{
        address = "131.215.104.21";
        prefixLength = 24;
      }];
    };
  };
      
  
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  # i18n.defaultLocale = "ja_JP.UTF-8";
  console = {
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    dpi = 160;
    upscaleDefaultCursor = true;

    displayManager.gdm = {
      autoSuspend = false;
      enable = false;
      wayland = true;
    };
    
    desktopManager.gnome.enable = false;
    desktopManager.plasma5 = {
      enable = true;
      useQtScaling = true;
    };
  };
  
  
  
  
  # Fix auto suspend
  # https://github.com/NixOS/nixpkgs/issues/100390
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.suspend" ||
            action.id == "org.freedesktop.login1.suspend-multiple-sessions" ||
            action.id == "org.freedesktop.login1.hibernate" ||
            action.id == "org.freedesktop.login1.hibernate-multiple-sessions")
        {
            return polkit.Result.NO;
        }
    });
  '';

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  
  # Fonts
  fonts = {
    packages = with pkgs; [
      carlito
      dejavu_fonts
      ipafont
      kochi-substitute
      source-code-pro
      ttf_bitstream_vera
      xkcd-font
      comic-neue
    ];
    fontconfig.defaultFonts = {
      monospace = [
        "DejaVu Sans Mono"
        "IPAGothic"
      ];
      sansSerif = [
        "DejaVu Sans"
        "IPAPGothic"
      ];
      serif = [
        "DejaVu Serif"
        "IPAPMincho"
      ];
    };
  };

  # QMK udev rules
  services.udev.packages = [ pkgs.qmk-udev-rules ];
  
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "colemak";
  services.xserver.xkb.options = "ctrl:nocaps"; # map caps to ctrl.

  # Gnome config
  services.gnome.tracker-miners.enable = false;
  services.gnome.tracker.enable = false;
  services.gnome.games.enable = false;

  # Enable dconf
  programs.dconf.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    nano
    wget
    home-manager
  ];

  programs.zsh.enable = true;

  # Enable some workarounds for steam per issue #47932
  nixpkgs.config.allowUnfreePredicate = (pkg: builtins.elem (lib.getName pkg) [
    "xkcd-font"
    "xkcd-font-unstable"
    "steam"
    "steam-run"
    "steam-original"
    "steam-runtime"
    "steam-unwrapped"
  ]);
  programs.steam.enable = true;

  users.users.chris = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFsVHSyjPxsGM1GAKy51YBBaZFpWBp0/lv1z3Ge6RFFH chris@Christophers-MacBook-Pro.local"
    ];
  };

  # users.users.stan = {
  #   isNormalUser = true;
  # };

  users.users.nadine = {
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMBZMZJseHjb6Wmf1WIybbWicyyZnaB9BUL6SuMr7CE4 nmeister@college.harvard.edu"
    ];
  };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';    
  };

  programs.singularity.enable = true;
}

