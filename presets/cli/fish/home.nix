{pkgs, ...}: {
  home.packages = [pkgs.fish];

  home.file = {
    ".config/fish/fish_file".source = ./fish_variables;
    ".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
    ".config/fish/conf.d/environment.fish".source = ./conf.d/environment.fish;
  };
}
