{pkgs, ...}: {
  environment = {
    sessionVariables = {
      # fight invisible cursors
      WLR_NO_HARDWARE_CURSORS = "1";
      # hint for wayland
      # NIXOS_OZONE_WL = "1";
    };
    gnome.excludePackages =
      (with pkgs; [
        gnome-photos
        gnome-tour
      ])
      ++ (with pkgs.gnome; [
        cheese # webcam tool
        gnome-music
        gnome-terminal
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ]);
    systemPackages = with pkgs; [
      gnome.adwaita-icon-theme
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.forge
      gnomeExtensions.vitals
    ];
  };

  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;
      xkb.layout = "de";
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      # was neccessary to change my keyboard to german. don`t ask
      # desktopManager.cinnamon.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
