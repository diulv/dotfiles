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

#attach to the default session
#check .tmux.conf for the default session configuration. the session is created when tmux runs, this then attaches to the session
alias tm="tmux attach -t dreifachverglasung" 

alias fzf="fzf --color='bg:237,bg+:236,info:143,border:240,spinner:108' --color='hl:65,fg:252,header:65,fg+:252' --color='pointer:161,marker:168,prompt:110,hl+:108'"

#source bash fzf keybindings
eval "$(fzf --bash)"
