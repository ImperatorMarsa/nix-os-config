# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    # <nixos-hardware/lenovo/thinkpad/x220>
    # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x220
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # FIXME: Add the rest of your current configuration
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-97e65866-ebb8-49e8-b89e-6e18e5e0ee9c".device = "/dev/disk/by-uuid/97e65866-ebb8-49e8-b89e-6e18e5e0ee9c";
  boot.initrd.luks.devices."luks-97e65866-ebb8-49e8-b89e-6e18e5e0ee9c".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "think-nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable DConf
  programs.dconf.enable = true;

  # Enable SShH-agent
  programs.ssh.startAgent = true;

  # Enable networking
  networking.networkmanager.enable = true;

  programs.fish.enable = true;
  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users.timofey = {
    # TODO: You can set an initial password for your user.
    # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
    # Be sure to change it (using passwd) after rebooting!
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Timofey";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    tmux
    wget
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  security.polkit.enable = true;

  #
  # List services that you want to enable:
  #

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable batarry mangment system
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        scaling_max_freq = 1500000;
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "always";
      };
    };
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Fingerptint reader setings
  services.fprintd.enable = true;
  security.pam.services = {
    sudo.fprintAuth = true;
    login.fprintAuth = true;
    greetd.fprintAuth = true;
    swaylock.fprintAuth = true;
    xscreensaver.fprintAuth = true;
    swaylock-effects.fprintAuth = true;
    system-local-login.fprintAuth = true;
  };

  # Set up dissplay manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "timofey";
      };
    };
  };
  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  #__ services.openssh = {
  #__   enable = true;
  #__   # Forbid root login through SSH.
  #__   permitRootLogin = "no";
  #__   # Use keys only. Remove if you want to SSH using password (not recommended)
  #__   passwordAuthentication = false;
  #__ };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
