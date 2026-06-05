#!/usr/bin/env bash

# Auto-start tmux in Ghostty on macOS.
#
# Unlike the other terminal start scripts in this directory, this one drives
# Ghostty through its native CLI (Ghostty >= 1.3.0) instead of System Events
# keystroke injection. `open --args -e tmux` runs tmux directly in the first
# surface, and the `fullscreen` config key enters native fullscreen. That means
# no Accessibility permission, no timing delays, and no Finder geometry hacks.
#
# For "true full screen" call the script with "fullscreen" as the first argument.
TRUE_FULL_SCREEN="$1"

main() {
	# `-e` must come last: it consumes every remaining argument as the command to
	# run. It also forces a fresh instance and quit-after-last-window-closed, so
	# the surface is the tmux client itself.
	if [ "$TRUE_FULL_SCREEN" == "fullscreen" ]; then
		# Native macOS fullscreen: the window gets its own Space.
		open -na Ghostty --args --fullscreen=true -e tmux
	else
		# Normal window. Ghostty restores the prior size/position when
		# window-save-state is enabled, otherwise it opens at the default size.
		open -na Ghostty --args -e tmux
	fi
}
main
