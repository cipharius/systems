{...}: {
  # Crucial for typical WiFi cards and also had trouble with amdgpu without this
  hardware.enableRedistributableFirmware = true;
}
