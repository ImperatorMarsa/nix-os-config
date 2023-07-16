{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Timofey Sitnikov";
    userEmail = "tima.sitnikov@mail.ru";
    extraConfig = {
      merge.conflictstyle = "diff3";
      pull.rebase = true;
    };
    delta = {
      enable = true;
      options = {
        dark = true;
        navigate = true;
        line-numbers = true;
        side-by-side = true;
        show-syntax-themes = true;
      };
    };
  };
}
