{pkgs, ...}: {
  programs.steam.enable = true;

  nixpkgs.allowUnfreeWhitelist = [
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXinerama
          xorg.libXi
          xorg.libXScrnSaver
          libpulseaudio
          libpng
          libvorbis
          libusb1
        ];
    };
  };
}
