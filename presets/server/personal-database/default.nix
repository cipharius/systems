{...}: {
  services.postgresql = {
    enable = true;
    ensureDatabases = ["personal"];
  };
}
