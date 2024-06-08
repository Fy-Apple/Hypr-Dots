eval "$(starship init zsh)"


# --- 全局初始化 ---
export https_proxy=http://192.168.1.2:7890;export http_proxy=http://192.168.1.2:7890;export all_proxy=socks5://192.168.1.2:7890
eval "$(dircolors -b)"


autoload -Uz compinit
compinit

# --- zinit 初始化 ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


# --- zinit 插件 ---(不要修改顺序)
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# --- 加载补全和配置 ---
# 内存中历史记录的大小
HISTSIZE=3000
# 历史记录文件的位置
HISTFILE=$HOME/.config/zsh/cache/zsh_history
# 保存在历史记录文件中的命令数
SAVEHIST=$HISTSIZE
# 每当一个命令被输入，再次保存到历史记录时，所有该命令的旧条目将被删除
HISTDUP=erase
# 将历史命令追加到历史文件中
setopt APPEND_HISTORY
 # 共享历史记录
setopt sharehistory
# 不显示 先前找到的行的重复项，即使重复项不是 连续
setopt HIST_FIND_NO_DUPS
# 如果添加到历史记录列表中的新命令行重复了 较旧的命令，较旧的命令将从列表中删除
setopt HIST_IGNORE_ALL_DUPS
# 忽略重复的历史记录条目
setopt HIST_IGNORE_DUPS
# 忽略以空格开头的命令，不将它们记录在历史记录中
setopt HIST_IGNORE_SPACE
# 保存历史记录时，不保存重复的命令
setopt HIST_SAVE_NO_DUPS
#keybingding
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# --- 初始化fzf---
source ~/.config/zsh/fzf.zsh
# --- 初始zoxide ---
source ~/.config/zsh/zoxide.zsh
# --- 初始化alias
source ~/.config/zsh/alias.zsh

source ~/.config/zsh/fzf-tab.zsh

# 鸭子退出时保存目录 
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ros2
source /opt/ros/jazzy/setup.zsh