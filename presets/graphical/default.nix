{pkgs, ...}: {
  imports = [
    ./chromium/default.nix
    ./feh/default.nix
    ./gimp/default.nix
    ./inkscape/default.nix
    ./libreoffice/default.nix
    ./paraview/default.nix
    ./pavucontrol/default.nix
    ./spotify/default.nix
    ./teams/default.nix
    ./vlc/default.nix
    ./xsel/default.nix
    ./zathura/default.nix
    ./zoom/default.nix
  ];

  # TODO Temporary housing, find a better place
  fonts = {
    packages = with pkgs; [powerline-fonts dejavu_fonts];

    fontconfig.defaultFonts = {
      monospace = ["DejaVu Sans Mono for Powerline"];
      sansSerif = ["DejaVu Sans"];
    };
  };
}
