{
  config,
  lib,
  pkgs,
  userName,
  ...
}: {
  imports = [];

  options.hosts.virtualisation = {
    docker.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Docker";
    };
    libvirt.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable libvirt";
    };
  };

  config = {
    environment.systemPackages = [
      pkgs.libguestfs
    ];

    virtualisation.libvirtd.enable = config.hosts.virtualisation.libvirt.enable;
    programs.virt-manager.enable = config.hosts.virtualisation.libvirt.enable;

    fileSystems."/var/lib/docker-data" = {
      device = "/var/lib/docker-store/docker.ext4.img";
      fsType = "ext4";
      options = ["loop"];
    };

    virtualisation.docker = {
      enable = true;
      #rootless = {
      #  enable = true;
      #  setSocketVariable = true;
      #};
      daemon.settings = {
        data-root = "/var/lib/docker-data";
        dns = ["8.8.8.8"];
      };
    };
    users.users.${userName}.extraGroups =
      (
        if config.hosts.virtualisation.docker.enable
        then ["docker"]
        else []
      )
      ++ (
        if config.hosts.virtualisation.libvirt.enable
        then ["libvirt"]
        else []
      );
  };
}
