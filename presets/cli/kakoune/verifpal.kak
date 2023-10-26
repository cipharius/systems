# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](vp) %{
    set-option buffer filetype verifpal
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=verifpal %{
    require-module verifpal
}

hook -group verifpal-highlight global WinSetOption filetype=verifpal %{
    add-highlighter window/verifpal ref verifpal
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/verifpal }
}

provide-module verifpal %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/verifpal group
add-highlighter shared/verifpal/keywords regex (attacker|principal|phase|queries|knows|private|public|password|generates|leaks|confidentiality\?|authentication\?|freshness\?|unlinkability\?|equivalence\?|precondition) 1:keyword
add-highlighter shared/verifpal/builtins regex (BLIND|UNBLIND|RINGSIGN|RINGSIGNVERIF|PW_HASH|HASH|HKDF|AEAD_ENC|AEAD_DEC|ENC|DEC|MAC|ASSERT|CONCAT|SPLIT|SIGN|SIGNVERIF|PKE_ENC|PKE_DEC|SHAMIR_SPLIT|SHAMIR_JOIN) 1:builtin
add-highlighter shared/verifpal/operator regex (\^|\?|=) 1:operator
add-highlighter shared/verifpal/message regex (\w+->\w+:)(?:\s*\w+\s*,|\s*(\[\w+\])\s*,)*(?:\s*\w+|\s*(\[\w+\]))? 1:attribute 2:operator 3:operator
add-highlighter shared/verifpal/comment regex //[^\n]* 0:comment

}
