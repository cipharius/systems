{pkgs, ...}: {
  home.packages = with pkgs; [
    (kakoune.override {
      configure = {
        plugins = with kakounePlugins; [
          kak-ansi
          prelude-kak
          kakoune-lsp
        ];
      };
    })

    lf # For filetree script
    universal-ctags # For ctags integration
    kakoune-cr # For session management and client spawning
    zls # Zig language server
    clang-tools # For C/C++ language server
    calc # For mathematical expression evaluation
    xsel # For system clipboard integration
  ];

  home.file = {
    ".config/kak/kakrc".source = ./kakrc;
    ".config/kak/scripts/lf.kak".source = ./lf.kak;
    ".config/kak/scripts/verifpal.kak".source = ./verifpal.kak;
    ".config/kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  };

  home.sessionVariables.EDITOR = "kak";
}
