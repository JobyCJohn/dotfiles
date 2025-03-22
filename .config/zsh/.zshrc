#### OPTIONS ####
# Core shell behavior tweaks
setopt correct              # Auto-correct command typos
setopt extendedglob         # Enable extended globbing patterns
setopt nocaseglob           # Case-insensitive globbing
setopt rcexpandparam        # Array expansions with parameters
setopt nocheckjobs          # Don't warn about background jobs on exit
setopt numericglobsort      # Numeric sorting in filename globs
setopt nobeep               # Disable terminal beep
setopt appendhistory        # Append commands to history immediately
setopt histignorealldups    # Remove older duplicates from history
setopt inc_append_history   # Save history incrementally
setopt histignorespace      # Ignore commands starting with space
setopt autocd               # Auto `cd` into directories by typing path only

#### HISTORY CONFIG ####
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

#### COMPLETION ####
autoload -U compinit
compinit -d

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Colored completion matches
zstyle ':completion:*' rehash true                        # Rehash commands on path change
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on

#### CURSOR STYLE ####
# Blinking green bar cursor
echo '\e[5 q'
echo -ne '\e]12;#00FF00\a'

#### KEYBINDINGS ####
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

#### OH-MY-ZSH CUSTOM PLUGINS ####
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh}"
source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$ZSH_CUSTOM/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

#### OH-MY-POSH ####
eval "$(oh-my-posh init zsh --config ~/.oh-my-posh/spaceship.omp.json)"

#### ENVIRONMENT VARIABLES ####
export VISUAL=nvim
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

#### CROSS-PLATFORM OPEN ALIAS ####
case "$OSTYPE" in
  linux*)  alias open='nohup nautilus . >/dev/null 2>&1 &' ;;
  darwin*) alias open='open' ;;
  cygwin*|msys*|win32*) alias open='explorer.exe' ;;
esac

#### LS COLOR CONFIGURATION ####
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls="ls $LS_OPTIONS"

#### THEMING ####
autoload -U colors
colors

#### COLORED MANPAGES ####
export LESS_TERMCAP_mb=$'\e[01;32m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;47;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;36m'
export LESS=-R

#### ALIASES & FUNCTIONS ####
alias fd='fdfind'
alias bat='batcat'

#### FZF CONFIGURATION ####
# Source key bindings and completion for fzf if available
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

# FZF_DEFAULT_COMMAND: use fdfind if available, fallback to find
if command -v fdfind > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude ".git" --exclude "*.vdi"'
else
  export FZF_DEFAULT_COMMAND='find . -type f ! -path "*/.git/*" ! -name "*.vdi"'
fi

# Preview command: use batcat if available, fallback to cat
export FZF_PREVIEW_COMMAND='bat --style=grid,header,numbers,changes --wrap=never --color=always {} 2>/dev/null || cat {}'

# FZF options with multiline for readability
export FZF_DEFAULT_OPTS=$(
  cat <<EOF
--multi --cycle
--height=80% --layout=reverse --info=inline
--preview-window=right:50%:wrap
--preview='$FZF_PREVIEW_COMMAND'
--ansi
EOF
)

# Use same default command for Ctrl-T integration
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Alt-C directory switcher: use fd if available, fallback to find (added fallback)
if command -v fd > /dev/null 2>&1; then
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
else
  export FZF_ALT_C_COMMAND='find . -type d ! -path "*/.git/*"'
fi
