# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
alias vimf='vim $(fzf)'
cdf() { file="$(fzf)"; [ -n "$file" ] && cd "$(dirname "$file")"; } 
#alias fzp
#alias fzt
alias ll='ls -alF'

# set hostname of window to ssh in tmux
# Make short hostname only if its not an IP address
# Make short hostname only if its not an IP address
