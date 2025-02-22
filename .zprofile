# PATH
export PATH="$HOME/.local/bin:$PATH"

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# FZF bases
export FZF_DEFAULT_OPTS="
  --color fg:#cdd6f4
  --color fg+:#cdd6f4
  --color bg+:#313244
  --color hl:#f38ba8
  --color hl+:#f38ba8
  --color info:#cba6f7
  --color prompt:#cba6f7
  --color spinner:#f5e0dc
  --color pointer:#f5e0dc
  --color marker:#f5e0dc
  --color border:#1e1e2e
  --color header:#f38ba8
  --prompt ' '
  --pointer ' λ'
  --layout=reverse
  --border horizontal
  --height 40"




# Path
export BUN_INSTALL="/home/nivaz/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_DATA_HOME/history"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# Start Sway environment
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec $HOME/.local/bin/hypr-start
fi
