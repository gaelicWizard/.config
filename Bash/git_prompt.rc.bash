: ${GIT_PROMPT_FETCH_REMOTE_STATUS:=} ${GIT_PROMPT_SHOW_UNTRACKED_FILES:=} ${GIT_PROMPT_IGNORE_SUBMODULES:=}
gp_install_prompt () 
{ 
	[[ -z "${OLD_GITPROMPT+x}" ]] && OLD_GITPROMPT=${PS1}
	[[ -z "${GIT_PROMPT_OLD_DIR_WAS_GIT+x}" ]] && GIT_PROMPT_OLD_DIR_WAS_GIT=$(we_are_on_repo)

	safe_append_prompt_command setLastCommandState
	safe_append_prompt_command setGitPrompt

	git_prompt_dir;
	_bash_it_log_section="git-prompt"
	source "${__GIT_PROMPT_DIR}/git-prompt-help.sh"
}
declare -Fr gp_install_prompt

if [ -x "${__GIT_PROMPT_DIR:=$(brew --prefix)/opt/bash-git-prompt/share}/gitprompt.sh" ]
then
	GIT_PROMPT_ONLY_IN_REPO=1
	_bash_it_log_section="git-prompt"
	source "${__GIT_PROMPT_DIR}/gitprompt.sh" 2> >(fgrep -v 'gp_install_prompt: readonly')
	_log_trace "${__bash_it_log_prefix[0]} + ${__bash_it_log_prefix[1]}"
	[[ "${__bash_it_log_prefix[0]}" == "git-prompt" && "${__bash_it_log_prefix[1]}" == "git_prompt.rc" ]] \
		&& _bash_it_log_prefix_pop "Sourcing gitprompt.sh fails part-way through and doesn't trigger RETURN trap..."
fi
