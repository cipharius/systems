{presets, ...}: {
  imports = [
    presets.test
  ];

  users.users.root = {
    password = "";
  };
}
