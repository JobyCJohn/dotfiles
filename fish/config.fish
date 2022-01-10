# initialization
oh-my-posh --init --shell fish --config ~/.poshthemes/spaceship.omp.json | source

# aliases
alias vim='nvim'

set -g -x fish_greeting

set -gx FZF_DEFAULT_OPTS "--height 50% --layout=reverse --inline-info"
