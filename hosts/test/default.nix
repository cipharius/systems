{presets, ...} @ args: {
  imports = [presets.default];

  nixpkgs.hostPlatform = "x86_64-linux";

  users.users.root = {
    password = "";
  };
}
