{pkgs, ...}: {
  home.packages = [pkgs.qutebrowser];

  home.file = {
    ".config/qutebrowser/config.py".source = ./config.py;
  };
}
