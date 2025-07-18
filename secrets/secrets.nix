let
  mcg-valts = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIGxaUQc7BEZhcmXNcqSHzbKmlmUSLZQ9F4j/ECy4Poy root@mcg-valts";
    valts = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmPt95vTEmI3eT0YALlDN3WWEFdLX1VKUTCbmrKmF7e+1Hy+rN1ln3ELi0kNmj9PEOM4aE7llIDXr8yE3kqMIHJudX1i3kKI9gKySbX8haT8u9MQsC4Nfc2oMz3BKsLvGkrBgCd9PMrTcx7iNC1HNF6RYXO8vP04wncHNRYffMD63t7FUoRkLqSDN9oOpHJ0pXrk1X97413zqcXpW997ASVuJEV6qADkdZXqOpZPPOI0Jav8uAXlsS0qsqwy7srxxeDSDSzUgwoeattLPBfpwQL1zatfTAWkWManvuulxHkybjWs68cnCQbGpUQlX945tTm+YpQtcE2fvtCL+DOigH95iH7hff/YWd72cipuY6VwyyxIMBK5qsPKehENPLb2B6r+jOxd3NedxZMzGYZob48uo1rMcGTJpckTCHFDZ/p3rVIrOIvXazHzXcMoEFvCiQNwiQkALXqvG+9PrSJ86rqu85eUfeGXQErYHpsANma/rw1n9/T3rJ1GRlmxAYZSU= valts@mcg-valts";
  };
  caminus = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINdNPE7drVRXhqpbfCc58qVbbjAc1kVLaXyQdpkhzwSt root@caminus";
    valts = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEM9a5Ln6HKk1eOmNE4ZrfMrw3Ec8axMmiwv0YDzxMLd valts@caminus";
  };
  armarium = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARs2WSLSiz0FeS2aCSIDG+nDjQkmLca0v2KvH908B6C root@armarium";
  };
  desktop = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4sFqu4C+Ki+aeuzjaHzi4mLwlt8PheQ5X0PxneEZu0 root@desktop";
  };
  ciphus = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGAR+jn8y+BORMZSmxguWEXkJQzEJT8GH6l5uULeI9GB root@nixos";
  };
  allKeys = [
    mcg-valts.root
    mcg-valts.valts
    caminus.root
    caminus.valts
    armarium.root
    desktop.root
    ciphus.root
  ];
in {
  "valts.age".publicKeys = allKeys;
  "emily.age".publicKeys = allKeys;
  "root.age".publicKeys = allKeys;
  "paperless-admin.age".publicKeys = allKeys;
  "wireless.age".publicKeys = allKeys;
  "wireguard-hpcr-private.age".publicKeys = allKeys;
  "wireguard-cronos-private.age".publicKeys = allKeys;
  "wireguard-tase-private.age".publicKeys = mcg-valts;
  "wpa-psk.age".publicKeys = allKeys;
}
