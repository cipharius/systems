{pkgs, ...}: {
  environment.systemPackages = [
      pkgs.micromamba
      (pkgs.python3.withPackages (p: [
          p.numpy
          p.matplotlib
          p.scipy
          p.pillow
      ]))
  ];
}
