#!/bin/bash --fail

# Specify defaults for Homebrew Cask.
# (Install cask with brew tap caskroom/cask and brew tap caskroom/versions.)
export HOMEBREW_CASK_OPTS="
--appdir=/Applications
--fontdir=/Library/Fonts
--colorpickerdir=/Library/ColorPickers
--prefpanedir=/Library/PreferencePanes
--qlplugindir=/Library/QuickLook
--mdimporterdir=/Library/Spotlight
--dictionarydir=/Library/Dictionaries
--servicedir=/Library/Services
--audio-unit-plugindir=/Library/Audio/Plug-Ins/Components
--vst-plugindir=/Library/Audio/Plug-Ins/VST
--vst3-plugindir=/Library/Audio/Plug-Ins/VST3

--input-methoddir=/Library/Input\ Methods
--internet-plugindir=/Library/Internet\ Plug-Ins
--screen-saverdir=/Library/Screen\ Savers
"
	# Use global /Applications instead of ~/Applications.

HB_CNF_HANDLER="$(brew --repo homebrew/command-not-found)/handler.sh"
if [ "${BASH_VERSINFO[0]}" -ge "4" ] && [ -r "$HB_CNF_HANDLER" ]
then
	source "$HB_CNF_HANDLER";
fi
