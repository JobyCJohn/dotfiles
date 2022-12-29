# Auto suggestions https://github.com/zsh-users/zsh-autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting https://github.com/zsh-users/zsh-syntax-highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# z for directory jumping
. $HOME/.config/zsh/z.sh

# Set language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# oh-my-posh
eval "$(oh-my-posh init zsh --config ~/.config/spaceship.omp.json)"

# fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude '(.git | *.vdi)'"
export FZF_PREVIEW_COMMAND="bat --style=grid,header,numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_DEFAULT_OPTS=" \
    --multi --cycle \
    --height=80% --layout=reverse --info=inline \
    --preview-window right:50%:wrap \
    --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null' \
    --ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
