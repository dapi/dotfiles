#!/bin/sh
#
#    tmux-detach-all-but-current-client
#    Copyright (C) 2013-2014 Dustin Kirkland
#
#    Authors: Dustin Kirkland <kirkland@byobu.org>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, version 3 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

a1=
a2=
tty1=
tty2=
# List all clients, ordered by most recent activity descending
for c in $(tmux list-clients -F "#{client_activity}___#{client_tty}" | sort -n -r); do
	if [ -z "$a1" ]; then
		a1=${c%%___*}
		tty1=${c##*___}
	elif [ -z "$a2" ]; then
		a2=${c%%___*}
		tty2=${c##*___}
	fi
	if [ -n "$a1" ] && [ -n "$a2" ]; then
		if [ "$a1" = "$a2" ]; then
			# Activity timestamps match in top 2 attached clients
			# Let's not detach anyone here!
			tmux display-message "Multiple active attached clients detected, refusing to detach" >/dev/null 2>&1
		elif [ -n "$tty1" ]; then
			# Detach all but the current client, iterating across each
			# Tempting to use detach-client -a -t here, but there's a bug
			# in there, keeping that from working properly
			tmux detach-client -t "$tty2" >/dev/null 2>&1
			a2=
		fi
	fi
done
