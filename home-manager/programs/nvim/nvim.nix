{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = [pkgs.vimPlugins.packer-nvim];
    #__ extraPackages = with pkgs; [
    #__   sumneko-lua-language-server
    #__   nodePackages.prettier
    #__   tree-sitter
    #__ ] ++ pkgs.tree-sitter.allGrammars;
  };
}
