{pkgs, ...}: {
  home.packages = with pkgs; [
    (kakoune.override {
      configure = {
        plugins = with kakounePlugins; [
          kak-ansi
          prelude-kak
        ];
      };
    })

    lf # For filetree script
    universal-ctags # For ctags integration
    kakoune-cr # For session management and client spawning
    zls # Zig language server
    calc # For mathematical expression evaluation
    xsel # For system clipboard integration
  ];

  home.file = {
    ".config/kak/kakrc".source = ./kakrc;
    ".config/kak/scripts/lf.kak".source = ./lf.kak;
    ".config/kak/scripts/verifpal.kak".source = ./verifpal.kak;
  };

  home.sessionVariables.EDITOR = "kak";
}
