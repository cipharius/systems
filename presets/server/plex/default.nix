{pkgs, ...}: {
  services.plex.enable = true;
  services.plex.openFirewall = true;

  nixpkgs.allowUnfreeWhitelist = ["plexmediaserver"];
}
