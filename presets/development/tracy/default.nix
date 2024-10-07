{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.tracy.overrideAttrs (final: prev: let
      version = "c4863d4324d0c8503f80f222d6a7b7d5f22aa597";
    in {
      version = "${version}";

      src = pkgs.fetchFromGitHub {
        owner = "wolfpld";
        repo = "tracy";
        rev = "${version}";
        hash = "sha256-bBbgBABcbyoAi6unNAtFlCLCrVXy4XuQXK2cF3BjkTc=";
      };
    }))
  ];
}
