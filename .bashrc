# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.bashrc_p ]; then
    . ~/.bashrc_p
fi

#^S
stty stop undef
#ika env desu...
export EDITOR=vi
#ika alias desu...
alias aptitude='sudo aptitude'
alias apt-get='sudo apt-get'
alias ifconfig="sudo ifconfig"
alias ifdown="sudo ifdown"
alias ifup="sudo ifup"
alias ifupdown="sudo ifupdown"
alias iptables="sudo iptables"
alias tcpdump="sudo tcpdump"
alias pidstat='pidstat'
alias ifstat='ifstat'
alias vmstat='sudo vmstat'
alias iostat='sudo iostat'
alias halt='sudo halt'
alias reboot='sudo reboot'

alias lsl='ls -al'
alias l='ls'
alias ll='ls -l'
alias lll='ls -al'
alias killk='kill -KILL'
alias pa='ps -A'

alias md='mkdir'
alias rd='rmdir'
alias rm='rm -i'

alias euc2sjis='iconv -f euc-jp -t sjis'
alias euc2utf='iconv -f euc-jp -t utf-8'
alias sjis2euc='iconv -f sjis -t euc-jp'
alias sjis2utf='iconv -f sjis -t utf-8'
alias utf2euc='iconv -f utf-8 -t euc-jp'
alias utf2sjis='iconv -f utf-8 -t sjis'
alias my-apt-why='dpkg -l | grep "^i" | awk "{print $2}" | xargs --max-args 1 aptitude why'
alias my-search-lostchild-apt='dpkg -l | grep "^i" | awk "{print $2}" | xargs --max-args 1 aptitude why | grep "^Unable"'
alias google='w3m www.google.co.jp'

alias reload='source ~/.bashrc'

alias resssh='sudo /etc/init.d/ssh restart'
alias ressmb='sudo /etc/init.d/samba restart'
alias resbi='sudo /etc/init.d/bind9 restart'
alias resap='sudo /etc/init.d/apache2 restart'

alias vivi='vi ~/.dotfiles/.vimrc'
alias virc='vi ~/.dotfiles/.bashrc'
alias videf='sudo vi /etc/apache2/sites-available/default'
alias viap='sudo vi /etc/apache2/apache2.conf'
alias vismb='sudo vi /etc/samba/smb.conf'
alias viint='sudo vi /etc/network/interfaces'
alias vissh='sudo vi /etc/ssh/sshd_config'

alias logac='sudo tail /var/log/apache2/access.log'
alias loger='sudo tail /var/log/apache2/error.log'
alias logacf='sudo tail -f /var/log/apache2/access.log'
alias logerf='sudo tail -f /var/log/apache2/error.log'
alias logacv='sudo vi /var/log/apache2/access.log'
alias logerv='sudo vi /var/log/apache2/error.log'
alias logacn='cat /var/log/apache2/access.log| grep -v 127.0.0.1 |grep -v 192.168.'
alias logacc='cat /var/log/apache2/access.log'

alias dstat-full='dstat -Tclmdrn'
alias dstat-mem='dstat -Tclm'
alias dstat-cpu='dstat -Tclr'
alias dstat-net='dstat -Tclnd'
alias dstat-disk='dstat -Tcldr'

#for git-completion
	#addされてない新規ファイルがある(untracked)とき"%"を表示する
	GIT_PS1_SHOWUNTRACKEDFILES=true

	#addされてない変更(unstaged)があったとき"*"を表示する、
	#addされているがcommitされていない変更(staged)があったとき"+"を表示する
	GIT_PS1_SHOWDIRTYSTATE=true

	#stashになにか入っている(stashed)とき"$"を表示する
	GIT_PS1_SHOWSTASHSTATE=true

	#現在のブランチがupstreamより進んでいるとき">"を、遅れているとき"<"を、遅れてるけど独自の変更もあるとき"<>"
	GIT_PS1_SHOWUPSTREAM=true

	export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

#for cocproxy.rb
source ~/.dotfiles/commonscript.sh

#for ruby
if [ -s ${HOME}/.rbenv ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
	source ~/.rbenv/completions/rbenv.bash
fi

	export GEM_HOME=~/.gem/
	export PATH=$GEM_HOME/bin:$PATH

#for perlbrew
if [ -s ~/perl5/perlbrew/etc/bashrc ]; then
	source ~/perl5/perlbrew/etc/bashrc
fi
