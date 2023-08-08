# Lf launcher

provide-module lf %{
  declare-option -hidden str lf_cmd %{connect terminal lf}
  declare-option -hidden str lf_params %{-command 'set preview!; set ratios 1; cmd open $(kcr open $fx; lf -remote "send $id quit")'}

  declare-user-mode lf-mode
  map global -docstring 'Open in pwd' \
    lf-mode w ': %opt{lf_cmd} %opt{lf_params}<a-!><ret>'
  map global -docstring 'Open in file dir' \
    lf-mode d ': %opt{lf_cmd} %opt{lf_params} %sh{dirname $kak_buffile}<a-!><ret>'
  map global -docstring 'Open in git root' \
    lf-mode p ': %opt{lf_cmd} %opt{lf_params} %sh{git rev-parse --show-toplevel}<a-!><ret>'
}
