{...}: {
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.pinentryFlavor = "curses";
}
