{pkgs, ...}: {
  environment.systemPackages = let
  tracyVersion = "da1bc2b60eed1a217af18324e60bc5fbc334ff20";
  in [
    (pkgs.tracy.overrideAttrs (final: prev: {
      version = tracyVersion;

      src = pkgs.fetchFromGitHub {
        owner = "wolfpld";
        repo = "tracy";
        rev = tracyVersion;
        hash = "sha256-oS8bzWyygPlMoKsUfWzjLUQN645KY3VOfpYSI82Sx5Y=";
      };
    }))
  ];
}
