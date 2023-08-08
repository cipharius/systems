{
  pkgs,
  presets,
  ...
}: {
  imports = [
    presets.graphical.kitty.home
  ];

  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  home = {
    packages = with pkgs; [
      libnotify
      playerctl
      acpi
      maim
    ];

    file = {
      ".xmonad/xmonad.hs".source = ./xmonad.hs;
    };
  };

  # Notifications daemon
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        geometry = "300x8-0+20";
        indicate_hidden = true;
        shrink = false;
        notification_height = 50;
        separator_height = 1;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 1;
        frame_color = "#dcdccc";
        seperator_color = "frame";
        idle_threshold = 120;
        font = "DejaVu Sans Mono 8";
        line_height = 0;
      };
      urgency_low = {
        background = "#707280";
        foreground = "#dcdccc";
        timeout = 10;
      };
      urgency_normal = {
        background = "#506070";
        foreground = "#ffffff";
        timeout = 10;
      };
      urgency_critical = {
        background = "#cc9393";
        foreground = "#ffffff";
        timeout = 0;
      };
    };
  };
}
