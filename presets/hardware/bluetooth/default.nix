{...}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      ControllerMode = "bredr";
    };
  };
  services.blueman.enable = true;
}
