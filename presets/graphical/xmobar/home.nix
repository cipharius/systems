{
  nixosConfig,
  pkgs,
  ...
}: let
  wlanifs =
    builtins.filter
    (str: (builtins.match "wl\.+" str) != null)
    (builtins.attrNames nixosConfig.networking.interfaces);

  wirelessConfigs =
    builtins.concatStringsSep "\n"
    (builtins.map
      (
        ifname: ''
          , Run Wireless "${ifname}"
            [ "-p","3"
            , "-t","<fc=#f0dfaf>Wlan:</fc> <essid>[<quality>%]"
            ] 10
        ''
      )
      wlanifs);

  wirelessComps = builtins.concatStringsSep " | " (builtins.map (ifname: "%${ifname}wi%") wlanifs);

  xmobarConfig = ''
    Config
      { font = "xft:DejaVu Sans Mono:size=11:bold:antialias=true"
      , bgColor  = "#3f3f3f"
      , fgColor  = "#dcdccc"
      , position = TopW L 100
      , lowerOnStart = True
      , commands =
        [ Run Date "%a %b %_d %H:%M" "date" 10
        , Run BatteryN ["BAT0"]
          [ "-p","3"
          , "-t","<fc=#f0dfaf>Batt:</fc> <left>%"
          ] 10 "battery"
        ${wirelessConfigs}
        , Run StdinReader
        , Run Com "sh" ["-c", "cat \"$HOME/CURRENT_TASK\""] "currentTask" 50
        ]
      , sepChar  = "%"
      , alignSep = "}{"
      , template = "%StdinReader% } <fc=#dfaf8f>%currentTask%</fc> { ${wirelessComps} | %battery%    <fc=#dfaf8f>%date%</fc>"
      }
  '';
in {
  home.packages = [pkgs.xmobar];
  home.file = {
    ".xmobarrc".text = xmobarConfig;
  };
}
