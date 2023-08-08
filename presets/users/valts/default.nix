{
  inputs,
  hostCfg,
  presets,
  ...
}: {
  home-manager.users.valts = {
    imports = with presets; [
      cli.direnv.home
      cli.git.home

      graphical.home
      graphical.godot.home

      cli.kakoune.home
      cli.pijul.home
      cli.youtubedl.home
      cli.taskwarrior.home
    ];

    home.stateVersion = hostCfg.stateVersion;
  };

  age.secrets.valts.file = "${inputs.self}/secrets/valts.age";

  users.users.valts = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video" "audio" "input" "docker" "libvirtd" "kvm" "scanner" "lp" "adbusers"];
    passwordFile = "/run/agenix/valts";
  };
}
