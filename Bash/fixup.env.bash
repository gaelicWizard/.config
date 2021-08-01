#!/bin/bash
# Adjust variables to be shell-friendly...because nobody can properly quote anything...

[[ "${GNUSTEP_USER_APPLICATION_SUPPORT:-}" != "${GNUSTEP_USER_APPLICATION_SUPPORT/Application Support/.ApplicationSupport}" ]] \
 && [[ -d "${GNUSTEP_USER_APPLICATION_SUPPORT/Application Support/.ApplicationSupport}" ]] \
  && GNUSTEP_USER_APPLICATION_SUPPORT="${GNUSTEP_USER_APPLICATION_SUPPORT/Application Support/.ApplicationSupport}"

[[ "${XDG_DATA_HOME:-}" != "${XDG_DATA_HOME/Application Support/.ApplicationSupport}" ]] \
 && [[ -d "${XDG_DATA_HOME/Application Support/.ApplicationSupport}" ]] \
  && XDG_DATA_HOME="${XDG_DATA_HOME/Application Support/.ApplicationSupport}"

[[ "${XDG_STATE_HOME:-}" != "${XDG_STATE_HOME/Saved Application State/.savedState}" ]] \
 && [[ -d "${XDG_STATE_HOME/Saved Application State/.savedState}" ]] \
  && XDG_STATE_HOME="${XDG_STATE_HOME/Saved Application State/.savedState}"




return

#TODO: can this functionate?
