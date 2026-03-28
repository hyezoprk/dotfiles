fish_add_path "/opt/homebrew/bin"
fish_add_path "/Users/hyezoprk/.local/bin"
set -Ux XDG_CONFIG_HOME $HOME/.config
set -gx PATH /opt/homebrew/opt/postgresql@17/bin $PATH
# set -x ANTHROPIC_API_KEY "sk-ant-xxxxxxxxxxxxxxxxxxxxxxxxxxxx"

zoxide init fish | source
starship init fish | source

# alias 단축어
alias de="cd ~/desktop"
alias config="cd ~/.config"
alias c="clear"
alias p="pnpm"
alias b="bun"
alias rand="openssl rand -base64 32"
alias port="lsof -i"
alias reboot="sudo shutdown -r now"
alias shutdown="sudo shutdown -h now"
alias sleep="pmset sleepnow"
alias reload="source ~/.config/fish/config.fish"
alias v="nvim"
alias vim="nvim"
alias t="tmux"
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -la"
alias lt="lsd --tree"
alias ping='prettyping --nolegend'
alias rds="find . -name ".DS_Store" -type f -delete"
alias yta='yt-dlp -x --audio-format mp3 --audio-quality 320k -o "%(title)s.%(ext)s"'
alias yt="yt-dlp"

alias cnext="pnpx create-next-app@latest"
alias cnest="nest new"
alias cvite="p create vite"
alias crn="pnpx create-expo-app@latest"

# pnpm
set -gx PNPM_HOME "/Users/hyezoprk/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by Antigravity
fish_add_path /Users/hyezoprk/.antigravity/antigravity/bin
