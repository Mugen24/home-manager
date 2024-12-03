{config, pkgs}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraconfig = '' 
      set tabstop=4
      set shiftwidth=4
      set expandtab
    ''
    plugins = with vimPlugins; {
      vimplugin-dracular.nvim
    }
  }
}
