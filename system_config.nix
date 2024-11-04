{
  pkgs, config, ...
}:
{

  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Autocompletion for systemd in zsh
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.pathsToLink = [ "/share/zsh" ];
  users.defaultUserShell = pkgs.zsh;

  services.xserver.windowManager.qtile = {
    configFile = ./config/qtile/config.py;
  }; 

  virtualisation.docker.enable = true;

  programs.git = {
    enable = true;
    config = {
      user = {
	email = "John.nguyen1022@gmail.com";
	name = "John Nguyen";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    firefox
    vesktop
    home-manager
    kitty
    xorg.xinit
    ntfs3g
    pavucontrol
    clinfo
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  users.users.mugen = {
    isNormalUser = true;
    description = "Mugen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  #https://www.reddit.com/r/NixOS/comments/185f0x4/how_to_mount_a_usb_drive/
  # Enable auto-mouning usbdrives
  services.devmon.enable = true;
  services.gvfs.enable = true; 
  services.udisks2.enable = true;

}
