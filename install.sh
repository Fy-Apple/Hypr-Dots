
# 清屏
clear

# 设置安装模式
mode="live"
if [ ! -z "$1" ]; then
    mode="dev"
    echo "IMPORTANT: DEV MODE ACTIVATED."
    echo "Existing dotfiles folder will not be modified."
    echo "Symbolic links will not be created."
fi

# 显示标题
echo -e "${GREEN}"
cat <<"EOF"
                  .:'
        __ :'__
     .'`  `-'  ``.
    :             :
    :             :
     :           :
      `.__.-.__.'
          :
          :
        ./
       :
EOF
echo -e "${NONE}"
echo "Version: $version"
echo

# 函数：检查是否为root用户
check_root() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "请勿使用root用户运行本脚本，请使用普通用户运行。" >&2
        exit 1
    fi
}

dirs=(
    "$HOME/Desktop"
    "$HOME/Documents"
    "$HOME/Downloads"
    "$HOME/Music"
    "$HOME/Pictures"
    "$HOME/Pictures/Wallpapers"
    "$HOME/Pictures/Screenshots"
    "$HOME/Pictures/Icons"
    "$HOME/Videos"
    "$HOME/Work"
    "$HOME/Backups"
    "$HOME/Development"
    "$HOME/Scripts"
    "$HOME/.config"
)

# Create each directory if it does not exist
for dir in "${dirs[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "Creating directory: $dir"
        mkdir -p "$dir"
    else
        echo "Directory already exists: $dir"
    fi
done


# 函数：安装包
install_packages() {
    local packages=(
        zsh
        fzf
        fd
        ripgrep
        eza
        zoxide
        ouch
        bat
        tldr
    )

    echo "将安装以下软件包：${packages[*]}"
    echo "确认安装吗？ (y/n)"
    read -r confirm

    if [ "$confirm" = "y" ]; then
        sudo pacman -Syu --needed "${packages[@]}"
    else
        echo "安装已取消"
    fi
}

# 函数：安装后配置
post_install_config() {
    echo "正在配置安装后的设置..."
    # 你可以在这里添加任何需要的软件配置命令
    sudo tldr --update
    echo "配置已完成"
}

# 主函数
main() {
    check_root
    install_packages
    post_install_config
    echo "所有操作已完成。"
}

# 执行主函数
main