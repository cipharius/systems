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

    universal-ctags # For ctags integration
    kakoune-cr # For session management and client spawning
    calc # For mathematical expression evaluation
    xsel # For system clipboard integration
  ];

  home.file = {
    ".config/kak/kakrc".source = ./kakrc;
    ".config/kak/scripts/verifpal.kak".source = ./kak_scripts/verifpal.kak;
    ".config/kak/scripts/fifo.kak".source = ./kak_scripts/fifo.kak;
    ".config/kak/scripts/ls.kak".source = ./kak_scripts/ls.kak;
    ".config/kak/scripts/list_buffers.kak".source = ./kak_scripts/list_buffers.kak;
    ".config/kak/scripts/explore.kak".source = ./kak_scripts/explore.kak;
  };

  home.sessionVariables.EDITOR = "kak";
}
