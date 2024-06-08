# --- zoxide config---

# zoxide 数据库存储目录（可选）
export _ZO_DATA_DIR="$HOME/.config/zsh/cache"

# 导航前打印目标目录
export _ZO_ECHO=1

# 排除系统目录和其他常见不需要记录的目录
export _ZO_EXCLUDE_DIRS="/bin/*:/boot/*:/dev/*:/etc/*:/lib/*:/lib64/*:/lost+found/*:/mnt/*:/opt/*:/proc/*:/root/*:/run/*:/sbin/*:/srv/*:/sys/*:/tmp/*:/usr/*:/var/*:/home/$USER/.local/*"

# 设置 fzf 的自定义选项（可选）
#export _ZO_FZF_OPTS="--height 40% --layout=reverse --border"

# 限制数据库的最大条目数
export _ZO_MAXAGE=6666

# 添加目录前解析符号链接,用于存储实际路径
#export _ZO_RESOLVE_SYMLINKS=1

# 初始化 zoxide
eval "$(zoxide init zsh)" # 对于 zsh
# eval "$(zoxide init bash)" # 对于 bash
