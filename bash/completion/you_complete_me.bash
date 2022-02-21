#!/etc/bash_completion
#
# Patch some functions from bash-completion...

__you_complete_me__reassemble_comp_words_by_ref_bad1='local exclude i j ref'
__you_complete_me__reassemble_comp_words_by_ref_fix1='local exclude= i j ref'
__you_complete_me__reassemble_comp_words_by_ref_bad2='=\\\${\!ref\}\\\$'
__you_complete_me__reassemble_comp_words_by_ref_fix2='=\${!ref-}\$'
__you_complete_me__reassemble_comp_words_by_ref_f="$(declare -f __reassemble_comp_words_by_ref)"
eval "${__you_complete_me__reassemble_comp_words_by_ref_f/$__you_complete_me__reassemble_comp_words_by_ref_bad1/$__you_complete_me__reassemble_comp_words_by_ref_fix1}"
__you_complete_me__reassemble_comp_words_by_ref_f="$(declare -f __reassemble_comp_words_by_ref)"
eval "${__you_complete_me__reassemble_comp_words_by_ref_f//$__you_complete_me__reassemble_comp_words_by_ref_bad2/$__you_complete_me__reassemble_comp_words_by_ref_fix2}"

__you_complete_me_cd_bad='k=\"\${\#COMPREPLY\[@\]\}\"'
__you_complete_me_cd_fix='COMPREPLY=(${COMPREPLY[@]-}); k="${#COMPREPLY[@]}"'
__you_complete_me_cd_f="$(declare -f _cd)"
eval "${__you_complete_me_cd_f/$__you_complete_me_cd_bad/$__you_complete_me_cd_fix}"

__you_complete_me_filedir_bad1='COMPREPLY=\(\"\${COMPREPLY\[@\]\}\" \"\${toks\[@\]\}\"\)'
__you_complete_me_filedir_fix1='COMPREPLY=(${COMPREPLY[@]-} ${toks[@]-})'
__you_complete_me_filedir_bad2=' \"\$1\" \!= -d '
__you_complete_me_filedir_fix2=' "${1:-}" != -d '
__you_complete_me_filedir_f="$(declare -f _filedir)"
eval "${__you_complete_me_filedir_f/$__you_complete_me_filedir_bad1/$__you_complete_me_filedir_fix1}"
__you_complete_me_filedir_f="$(declare -f _filedir)"
eval "${__you_complete_me_filedir_f/$__you_complete_me_filedir_bad2/$__you_complete_me_filedir_fix2}"

__you_complete_me_get_comp_words_by_ref_bad1='local upargs=() upvars=() vcur vcword vprev vwords;'
__you_complete_me_get_comp_words_by_ref_fix1='local upargs=() upvars=() vcur= vcword= vprev= vwords=;'
__you_complete_me_get_comp_words_by_ref_f="$(declare -f _get_comp_words_by_ref)"
eval "${__you_complete_me_get_comp_words_by_ref_f/$__you_complete_me_get_comp_words_by_ref_bad1/$__you_complete_me_get_comp_words_by_ref_fix1}"

unset ${!__you_complete_me_@}
return
