{pkgs, ...}: {
  home.packages = [pkgs.pijul];

  home.file = {
    ".config/pijul/config.toml".source = ./config.toml;
  };
}
