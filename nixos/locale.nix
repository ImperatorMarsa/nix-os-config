{ inputs, lib, config, pkgs, ... }: {
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_NAME = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
  };

  console.useXkbConfig = true;
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle";
  };
}

