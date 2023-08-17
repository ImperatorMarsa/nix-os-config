{ config, pkgs, ... }:

{
  programs.kakoune = {
    enable = true;
    plugins = with pkgs.kakounePlugins; [
      kak-fzf
      # kak-lsp
    ];
  };
}
