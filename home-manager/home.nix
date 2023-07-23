# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # Lang
  home.language = let
      en = "en_US.UTF-8";
      ru = "ru_RU.UTF-8";
  in {
      base     = en;
      time     = en;
      paper    = ru;
      address  = ru;
      monetary = ru;
  };
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./programs/programs.nix
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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # TODO: Set your username
  home = {
    username = "timofey";
    homeDirectory = "/home/timofey";
  };

  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # cli tools
    pkgs.vim
    pkgs.bat
    pkgs.fzf
    pkgs.btop
    pkgs.gping
    pkgs.pfetch
    pkgs.zellij
    pkgs.ripgrep
    pkgs.brightnessctl

    # security
    pkgs.keepassxc

    # utils
    pkgs.du-dust
    pkgs.xdg-utils
    pkgs.libnotify
    pkgs.glibcLocales
    pkgs.wl-clipboard
    pkgs.any-nix-shell
    pkgs.dracula-theme
    pkgs.pulseaudioFull
    pkgs.dracula-icon-theme

    # desktop
    pkgs.waybar
    pkgs.wezterm
    pkgs.swaylock
    pkgs.xfce.thunar
    pkgs.rofi-wayland

    # internet
    pkgs.openvpn
    pkgs.remmina
    pkgs.yandex-disk
    pkgs.skypeforlinux
    pkgs.telegram-desktop
    pkgs.pkgs.appimage-run
    pkgs.networkmanager-openvpn
    pkgs.thunderbird
    pkgs.thunderbirdPackages.thunderbird-115

    # fonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.font-awesome
    pkgs.jetbrains-mono

    # pkgs.wezterm # ne mogu ponyat v chem problema. ustanovlyu cherez defoltniy manager paketov
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".vimrc".source           = ./configs/vim/vimrc;
    ".config/lsd".source      = ./configs/lsd;
    ".config/rofi".source     = ./configs/rofi;
    ".config/sway".source     = ./configs/sway;
    ".config/waybar".source   = ./configs/waybar;
    ".config/wezterm".source  = ./configs/wezterm;
    ".config/swaylock".source = ./configs/swaylock;
  };


  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
    };
  };

  # Setting Up Dracula theme
  qt = {
    enable = true;
    style = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
    size = 16;
  };

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    PAGER = "less -FirSwX";
    TERMINAL = "wezterm";
    BROWSER = "firefox";
    WAYLAND_DISPLAY = "wayland-1";
    NIXOS_OZONE_WL = "1";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # notification daemon
  services.mako = {
    enable = true;
    defaultTimeout = 10000;

    font = "JetBrains Nerd Font Mono 12";

    backgroundColor = "#44475a";
    textColor = "#f8f8f2";
    borderColor = "#282a36";
    borderSize = 3;

    extraConfig = ''
      [urgency=low]
      border-color=#282a36

      [urgency=normal]
      border-color=#f1fa8c

      [urgency=critical]
      ignore-timeout=1
      text-color=#ff79c6
      border-color=#ff5555
      default-timeout=30000
    '';
  };
  systemd.user.services.mako = {
    Unit = {
      Description = "Mako notification daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.mako}/bin/mako";
      RestartSec = 5;
      Restart = "always";
    };
    environment = {
      WAYLAND_DISPLAY = "wayland-1";
    };
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
  #__ news.display = "show";
}
