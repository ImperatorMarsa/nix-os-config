{ config, pkgs, ... }:

let
  nvim-spell-ru-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/ru.utf-8.spl";
    sha256 = "eb2d3bd78a2020b30bcc0a7cfebdacebfb7a427581114f66b88a577ae6dac54d";
  };
  nvim-spell-ru-utf8-suggestions = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/ru.utf-8.sug";
    sha256 = "eabd86168ad85d5bfb8068808cf7982bab0374afc299cb49ecc89d71616f393b";
  };
  nvim-spell-en-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl";
    sha256 = "fecabdc949b6a39d32c0899fa2545eab25e63f2ed0a33c4ad1511426384d3070";
  };
  nvim-spell-en-utf8-suggestions = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.sug";
    sha256 = "5b6e5e6165582d2fd7a1bfa41fbce8242c72476222c55d17c2aa2ba933c932ec";
  };
in
{
  programs.neovim = {
    enable = true;
    plugins = [ pkgs.vimPlugins.packer-nvim ];
    #__ extraPackages = with pkgs; [
    #__   sumneko-lua-language-server
    #__   nodePackages.prettier
    #__   tree-sitter
    #__ ] ++ pkgs.tree-sitter.allGrammars;
  };

  home.file."${config.xdg.configHome}/nvim/spell/ru.utf-8.spl".source = nvim-spell-ru-utf8-dictionary;
  home.file."${config.xdg.configHome}/nvim/spell/ru.utf-8.sug".source = nvim-spell-ru-utf8-suggestions;
  home.file."${config.xdg.configHome}/nvim/spell/en.utf-8.spl".source = nvim-spell-en-utf8-dictionary;
  home.file."${config.xdg.configHome}/nvim/spell/en.utf-8.sug".source = nvim-spell-en-utf8-suggestions;
}
