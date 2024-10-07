{pkgs, ...}: {
  services.libinput.enable = true;
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;

    # Allow home manager to provide window manager
    desktopManager.session = [
      {
        name = "home-manager";
        start = ''
          ${pkgs.runtimeShell} $HOME/.hm-xsession &
          waitPID=$!
        '';
      }
    ];
  };
}
