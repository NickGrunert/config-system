{
  config,
  pkgs,
  ...
}: {
  imports = [./opengl.nix];

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    # Make sure to use the correct Bus ID values for your system!
    intelBusId = "PCI:0:1:0";
    nvidiaBusId = "PCI:0:0:2";
    # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
  };

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.systemPackages = [
    # only cuda 12+ support => other problems, hence broken at the moment
    # (pkgs.cudaPackages.tensorrt.override { autoAddDriverRunpath = pkgs.autoAddDriverRunpath; })
    pkgs.cudaPackages.cudnn
    pkgs.cudaPackages.cutensor
    pkgs.cudaPackages.cuda_opencl
    pkgs.cudaPackages.cudatoolkit
    pkgs.linuxPackages.nvidia_x11
  ];

  virtualisation.docker.enableNvidia = false;
}
