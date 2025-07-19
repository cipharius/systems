{
  inputs,
  hostCfg,
  presets,
  pkgs,
  ...
}:
let
  micromamba-fhs = pkgs.buildFHSEnv {
      name = "micromamba-fhs";
      targetPkgs = _: [
          pkgs.micromamba
      ];
      profile = ''
        set -e
        eval "$(micromamba shell hook --shell=posix)"
        set +e
      '';
  };
in
{
  home-manager.users.emily = {
    imports = with presets; [];

    home.stateVersion = hostCfg.stateVersion;
  };

  age.secrets.emily.file = "${inputs.self}/secrets/emily.age";
  environment.systemPackages = [ micromamba-fhs ];

  users.users.emily = {
    shell = "${micromamba-fhs}/bin/micromamba-fhs";
    isNormalUser = true;
    extraGroups = ["networkmanager" "video" "audio" "input" "docker" "libvirtd" "kvm" "scanner" "lp" "adbusers"];
    hashedPasswordFile = "/run/agenix/emily";
  };
}
