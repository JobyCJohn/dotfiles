if status is-interactive
and not set -q TMUX
    tmux attach || tmux
end

# initialization
oh-my-posh --init --shell fish --config ~/.poshthemes/spaceship.omp.json | source

# aliases
alias git='git.exe'
alias open='wsl-open'

set -gx fish_greeting
set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS "--height 50% --layout=reverse --inline-info"
