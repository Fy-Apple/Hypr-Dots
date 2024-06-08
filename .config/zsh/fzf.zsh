# --- fzf 配置文件 ---


# █▀▀ █▄░█ █░█
# ██▄ █░▀█ ▀▄▀
# --- 默认查找为全家目录查找 ---
export FZF_DEFAULT_COMMAND='fd --hidden --follow --color=always --exclude .git --exclude .vscode --exclude build . "$HOME" "/etc" '
# --- 配置默认样式 ---
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#eeeeee,bg:-1,bg+:#262626
  --color=hl:#b294bb,hl+:#5fd7ff,info:#c0eb98,marker:#d53d3d
  --color=prompt:#ee4d4d,spinner:#8abeb7,pointer:#ffeb66,header:#81e6e6
  --color=gutter:#333333,border:#fbe8f1,scrollbar:#b4aeb2,preview-scrollbar:#5d5d5d
  --color=label:#c5c8c6,query:#f0c674
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt=" 🔍"
  --marker="√" --pointer="➤" --separator="─" --scrollbar="▒"
  --preview-window=right:65% --height=60% --min-height=12
  --ansi
  --layout="reverse" --info="right"
  --bind "ctrl-u:preview-up"
  --bind "ctrl-d:preview-down"
'

# 设置 CTRL_T 以使用 fd 查找文件
export FZF_CTRL_T_COMMAND='fd --type f --color=always --exclude build'
preview="\
case \$(file --mime-type -Lb {}) in
  text/*) bat --style=numbers,grid,header --color=always --theme="OneHalfDark" {} ;;
  image/*) ~/.config/zsh/img_preview.zsh {} ;;
  application/pdf) mupdf {} ;;
  application/x-tar|application/zip|application/x-7z-compressed|application/gzip|application/x-xz|\
  application/x-lzma|application/x-bzip2|application/x-lz4|application/vnd.google.snaappy|application/zstd|\
  application/x-rar ) ouch list {} --tree ;;
  *) echo 'Filetype not supported for preview' ;;
esac"
# 设置 CTRL_T 以配置 fzf 显示选项和预览
export FZF_CTRL_T_OPTS="--header 'CTRL+H: toggle to search for hidden files'
        --prompt 'Default> '
        --bind 'ctrl-h:change-prompt(Hidden > )+reload(fd --type f --hidden --color=always --exclude .git --exclude .vscode --exclude build)'
        --bind 'ctrl-t:change-prompt(Default> )+reload(fd --type f --color=always --exclude build)'
        --preview \"${preview}\"
"



# 设置 ALT_C以使用 fd 查找目录
export FZF_ALT_C_COMMAND='fd --type d --color=always --exclude build'
# 设置 ALT_C 以配置 fzf 显示选项、预览等
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=3 --icons=always --color=always {} | head -200'
        --header 'CTRL+H: Toggle to search for hidden directories'
        --prompt 'Default> '
        --bind 'ctrl-h:change-prompt(Hidden > )+reload(fd --type d --hidden --color=always --exclude .git --exclude .vscode --exclude build)'
        --bind 'alt-c:change-prompt(Default> )+reload(fd --type d --color=always --exclude build)'
"

# 设置 CTRL_R 以设置复制命令和查看详细命令
export FZF_CTRL_R_OPTS="
  --preview 'echo {} | GREP_COLORS=\"ms=01;33\" grep --color=always .'
  --preview-window up:follow:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard ,Press ctrl+/ to display the full command'
"

# 设置CTRL_G 以设置rg结合fzf通过文本内容实时查找文件名并实时预览
fzf_rg_search() {
# Switch between Ripgrep mode and fzf filtering mode (CTRL-T)
rm -f /tmp/rg-fzf-{r,f}
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case -g '!bin/*' -g '!/boot/*' -g '!/dev/*' -g '!/etc/*' -g !'/lib/*' -g '!/lib64/*' -g '!/lost+found/*' -g !'/mnt/*' -g '!/opt/*' -g '!/proc/*' -g '!/run/*' -g '!/sbin/*' -g '!/srv/*' -g '!/sys/*' -g '!/tmp/*' -g '!/usr/*' -g '!/var/*' -g '!/home/$USER/.local/*' "
INITIAL_QUERY="${*:-}"
: | fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --bind 'ctrl-t:transform:[[ ! $FZF_PROMPT =~ ripgrep ]] &&
      echo "rebind(change)+change-prompt(1. ripgrep> )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" ||
      echo "unbind(change)+change-prompt(2. fzf> )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --prompt '1. ripgrep> ' \
    --delimiter : \
    --header 'CTRL-T: Switch between ripgrep/fzf' \
    --preview 'bat --color=always {1} --highlight-line {2} --theme="OneHalfDark" --style=numbers,grid' \
    --preview-window 'right,60%,+{2}+3/3,~3' \
    --bind 'enter:become(vim {1} +{2})'


#RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
#INITIAL_QUERY="${*:-}"
#: | fzf --ansi --disabled --query "$INITIAL_QUERY" --prompt="Default" \
#  --bind "start:reload:([[ -n {q} ]] && $RG_PREFIX {q} 2>/dev/null || echo '')" \
#  --bind "change:transform:([[ \$FZF_PROMPT = Default ]] && ([[ -n {q} ]] && echo reload:$RG_PREFIX {q} 2>/dev/null || echo reload:sleep 0.1;echo '') || ([[ -n {q} ]] && echo reload:$RG_PREFIX --hidden {q} 2>/dev/null || echo reload:sleep 0.1;echo '')); true" \
#  --delimiter : \
#  --bind "ctrl-h:change-prompt(Hidden>)+reload([[ -n {q} ]] && $RG_PREFIX --hidden {q} 2>/dev/null || echo '')" \
#  --bind "ctrl-g:change-prompt(Default>)+reload([[ -n {q} ]] && $RG_PREFIX {q} 2>/dev/null || echo '')" \
#  --preview 'if [[ -n {1} ]]; then bat --theme="OneHalfDark" --style=grid,numbers,header --color=always {1} --highlight-line {2}; else echo -e "\033[38;5;160mNo matching files found\033[0m"; fi' \
#  --preview-window 'right:60%:+{2}+3/3,~3' \
#  --bind 'enter:become(nvim {1}+{2})'

}
# 绑定快捷键
zle -N fzf_rg_search
bindkey '^G' fzf_rg_search



# 初始fzf并启用zsh的补全和键绑定
eval "$(fzf --zsh)"


# other
