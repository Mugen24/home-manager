{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghc 
    haskell-language-server
  ];
  home.file.ghci = {
    target = ".haskeline";
    text = ''
      editMode: Vi
    '';
  };
}

