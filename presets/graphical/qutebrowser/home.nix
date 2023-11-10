{pkgs, ...}: {
  home.packages = [
    (pkgs.qutebrowser.override {
      enableVulkan = false;
    })
  ];

  home.file = {
    ".config/qutebrowser/config.py".source = ./config.py;
  };
}
