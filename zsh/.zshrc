# Enable Powerlevel11k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


ZSH_THEME="robbyrussell"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(ls|cd|pwd|exit)*"
setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export HIST_STAMPS="yyyy-mm-dd"
bindkey "^E" history-incremental-search-backward  # CTRL+E
bindkey "^S" history-incremental-search-forward   # CTRL+S

plugins=(git macos python zsh-autosuggestions zsh-z fzf tmux)

source $ZSH/oh-my-zsh.sh

# Aliases
alias docc="docker-compose"
alias b=buffalo
alias gbra="git branch | grep -E -v 'master|main' | xargs git branch -D"
alias python=python3


source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# LIBPQ
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# GOLANG
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export GOLANGCI_LINT_CACHE="$HOME/.cache/golangci-lint"

# Heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/agus/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;


# Shell integration
source ~/.iterm2_shell_integration.zsh

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Poetry
export PATH="/Users/agus/.local/bin:$PATH"

# Granted.dev
export GRANTED_ENABLE_AUTO_REASSUME=true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# tmux integration
export TERM=xterm-256color


# claude
alias cc='claude'
alias claudio='claude --dangerously-skip-permissions'


# custom commands
wt() { /Users/agus/bin/wt "$@"; [ -f ~/.wt_cd_to ] && cd "$(cat ~/.wt_cd_to)" && rm ~/.wt_cd_to; }
export PATH="$HOME/bin:$PATH"