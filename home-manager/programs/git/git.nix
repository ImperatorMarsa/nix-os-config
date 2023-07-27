{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Timofey Sitnikov";
    userEmail = "tima.sitnikov@mail.ru";
    extraConfig = {
      pull.rebase = true;
      core = { editor = "nvim"; };
      merge.conflictstyle = "diff3";
    };
    delta = {
      enable = true;
      options = {
        dark = true;
        navigate = true;
        line-numbers = true;
        side-by-side = true;
        show-syntax-themes = true;
        syntax-theme = "dracula";
      };
    };
  };
}
