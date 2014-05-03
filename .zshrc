# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="myessembeh"


# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

plugins=(autojump compleat command-not-found git cpanm debian dircycle dirhistory rand-quote tmux urltools wd)

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

eval `dircolors ~/.dircolors`
export EDITOR=vi
bindkey -e
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward


zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#---- https://gist.github.com/mollifier/4979906
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
							/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# '#' 以降をコメントとして扱う
setopt interactive_comments
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu
# 高機能なワイルドカード展開を使用する
setopt extended_glob
# ディレクトリ名と一致した場合 cd
setopt auto_cd
setopt autopushd
# 同じディレクトリは追加しない
setopt pushd_ignore_dups

#sudo横着系
alias aptitude='sudo aptitude'
alias apt-get='sudo apt-get'
alias ifconfig="sudo ifconfig"
alias ifdown="sudo ifdown"
alias ifup="sudo ifup"
alias ifupdown="sudo ifupdown"
alias iptables="sudo iptables"
alias tcpdump="sudo tcpdump"
alias vmstat='sudo vmstat'
alias iostat='sudo iostat'
alias halt='sudo halt'
alias reboot='sudo reboot'

alias ls='ls --color=auto -F'

alias vizsh='vi ~/.zshrc'
alias vivi='vi ~/.dotfiles/.vimrc'
alias virc='vi ~/.dotfiles/.bashrc'
alias reload='source ~/.zshrc'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias -g throwaway="> /dev/null 2>&1"
alias ps='ps -f'
alias lsl='ls -al'
alias l='ls'
alias ll='ls -l'
alias lll='ls -al'
alias killk='kill -KILL'
alias pa='ps -A'


alias md='mkdir'
alias rd='rmdir'
alias rm='rm -i'
# print all installed packages
alias allpkgs='aptitude search -F "%p" --disable-columns ~i'

alias euc2sjis='iconv -f euc-jp -t sjis'
alias euc2utf='iconv -f euc-jp -t utf-8'
alias sjis2euc='iconv -f sjis -t euc-jp'
alias sjis2utf='iconv -f sjis -t utf-8'
alias utf2euc='iconv -f utf-8 -t euc-jp'
alias utf2sjis='iconv -f utf-8 -t sjis'
alias my-apt-why='dpkg -l | grep "^i" | awk "{print $2}" | xargs --max-args 1 aptitude why'
alias my-search-lostchild-apt='dpkg -l | grep "^i" | awk "{print $2}" | xargs --max-args 1 aptitude why | grep "^Unable"'
alias google='w3m www.google.co.jp'

alias resssh='sudo /etc/init.d/ssh restart'
alias ressmb='sudo /etc/init.d/samba restart'
alias resbi='sudo /etc/init.d/bind9 restart'
alias resap='sudo /etc/init.d/apache2 restart'

alias videf='sudo vi /etc/apache2/sites-available/default'
alias viap='sudo vi /etc/apache2/apache2.conf'
alias vismb='sudo vi /etc/samba/smb.conf'
alias viint='sudo vi /etc/network/interfaces'
alias vissh='sudo vi /etc/ssh/sshd_config'
alias vizone='sudo vi /etc/bind/iaskell.dyndns.org/iaskell.dyndns.org.zone'

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

apt-history () {
  case "$1" in
    install)
      zgrep --no-filename 'install ' $(ls -rt /var/log/dpkg*)
      ;;
    upgrade|remove)
      zgrep --no-filename $1 $(ls -rt /var/log/dpkg*)
      ;;
    rollback)
      zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) | \
        grep "$2" -A10000000 | \
        grep "$3" -B10000000 | \
        awk '{print $4"="$5}'
      ;;
    list)
      zcat $(ls -rt /var/log/dpkg*)
      ;;
    *)
      echo "Parameters:"
      echo " install - Lists all packages that have been installed."
      echo " upgrade - Lists all packages that have been upgraded."
      echo " remove - Lists all packages that have been removed."
      echo " rollback - Lists rollback information."
      echo " list - Lists all contains of dpkg logs."
      ;;
  esac
}

#for ruby
if [ -s ${HOME}/.rbenv ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
	source ~/.rbenv/completions/rbenv.zsh
fi

export GEM_HOME=~/.gem/
export PATH=$GEM_HOME/bin:$PATH

#for perlbrew
if [ -s ~/perl5/perlbrew/etc/bashrc ]; then
	source ~/perl5/perlbrew/etc/bashrc
fi

#前回終了時のパスに移動
#cd `cat ~/.curdir`
last
