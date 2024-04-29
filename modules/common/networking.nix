{
  hostId,
  hostName,
  userName,
  ...
}: {
  networking = {
    inherit hostId hostName;
    wireless.enable = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 8080 2375 6443];
      allowedUDPPorts = [53 5353];
    };
  };

  users.users.${userName}.extraGroups = ["networkmanager"];
}
