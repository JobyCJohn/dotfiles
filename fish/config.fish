# Initialization
oh-my-posh --init --shell fish --config ~/.config/spaceship.omp.json | source

# Remove fish welcome message
set fish_greeting

# Key bindings
bind -M insert "¸" fzf-cd-widget

# Aliases
alias vim='nvim'

set TERM "xterm-256color"
set EDITOR "nvim"
set FZF_DEFAULT_COMMAND "fd --hidden --no-ignore --follow --exclude='**/.git/'"
set FZF_DEFAULT_OPTS " \
    --multi --cycle --keep-right -1 \
    --height=80% --layout=reverse --info=default \
    --preview-window right:50%:wrap \
    --preview 'fzf_preview {}' \
    --ansi"
set FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Functions
function fzf_preview
    if file --mime "$argv" | grep -q directory
        tree -L 3 "$argv"
    else if file --mime "$argv" | grep -q binary
        echo "$argv is a binary file"
    else
        if command --quiet --search bat
            bat --color=always --line-range :250 "$argv"
        else if command --quiet --search cat
            cat "$argv" | head -250
        else
            head -250 "$argv"
        end
    end
end

