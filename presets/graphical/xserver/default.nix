{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    libinput.enable = true;

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
