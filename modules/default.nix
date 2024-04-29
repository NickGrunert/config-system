{pkgs, ...}: {
  imports = [
    ./common
    ./desktop
    ./multimedia
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    optimise = {
      automatic = true;
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      trusted-users = ["root"];
    };
  };

  boot = {
    supportedFilesystems = ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };
  };

  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = let
      extraLocale = "en_US.UTF-8";
    in {
      LC_ADDRESS = extraLocale;
      LC_IDENTIFICATION = extraLocale;
      LC_MEASUREMENT = extraLocale;
      LC_MONETARY = extraLocale;
      LC_NAME = extraLocale;
      LC_NUMERIC = extraLocale;
      LC_PAPER = extraLocale;
      LC_TELEPHONE = extraLocale;
      LC_TIME = extraLocale;
    };
  };

  environment = {
    systemPackages = [
      # Defaults
      pkgs.curl
      pkgs.git
      pkgs.ripgrep
      pkgs.tree
      pkgs.wget
      pkgs.vim
      pkgs.which
      pkgs.jq

      pkgs.openssh
      pkgs.pinentry

      # Further tools
      pkgs.paperkey
      pkgs.pcsctools
    ];
  };

  programs = {
    direnv.enable = true;
  };

  console.keyMap = "de";

  services = {
    pcscd.enable = true;
  };

  fonts.packages = [
    pkgs.dejavu_fonts
    pkgs.cm_unicode
    pkgs.libertine
    pkgs.roboto
    pkgs.noto-fonts
  ];
}
