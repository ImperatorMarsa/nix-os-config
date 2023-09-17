{ inputs, lib, config, pkgs, ... }: {
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      font-awesome
      jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "JetBrainsMono" ];
        sansSerif = [ "JetBrainsMono" ];
        monospace = [ "JetBrainsMono" ];
      };
    };
  };
}

