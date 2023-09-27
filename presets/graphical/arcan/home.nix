{config, ...}: {
  home.sessionVariables.ARCAN_STATEPATH = "${config.home.homeDirectory}";
}
