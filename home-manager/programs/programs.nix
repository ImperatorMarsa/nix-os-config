{ config, pkgs, ... }:

{
  imports = [
    ./lsd/lsd.nix
    ./git/git.nix
    ./tmux/tmux.nix
    ./fish/fish.nix
    ./nvim/nvim.nix
    ./zoxide/zoxide.nix
    ./kakoune/kakoune.nix
    ./firefox/firefox.nix
    ./lazygit/lazygit.nix
  ];

  programs = {
    starship.enable = true;
  };
}
