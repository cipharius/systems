{pkgs, ...}: {
  home.packages = with pkgs; [
    taskwarrior3
    timewarrior
  ];

  home.file = {
    ".task/hooks/on-exit_update-current-task.sh" = {
      source = ./on-exit_update-current-task.sh;
      executable = true;
    };
  };
}
