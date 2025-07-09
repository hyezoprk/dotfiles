fish_add_path "/opt/homebrew/bin"
fish_add_path "/Users/hoonyboom/.local/bin"
set -gx PATH /opt/homebrew/opt/postgresql@17/bin $PATH
# set -x ANTHROPIC_API_KEY "sk-ant-xxxxxxxxxxxxxxxxxxxxxxxxxxxx"

zoxide init fish | source
starship init fish | source

# alias 단축어
alias de="cd ~/desktop"
alias config="cd ~/.config"
alias c="clear"
alias p="pnpm"
alias rand="openssl rand -base64 32"
alias port="lsof -i"
alias reboot="sudo shutdown -r now"
alias shutdown="sudo shutdown -h now"
alias sleep="pmset sleepnow"
alias v="nvim"
alias vim="nvim"
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -la"
alias lt="lsd --tree"
alias ping='prettyping --nolegend'
alias top="btop"
alias rds="find . -name ".DS_Store" -type f -delete"
alias cnext="pnpx create-next-app@latest"
alias cnest="nest new"
alias cvite="p create vite"
alias crn="pnpx create-expo-app@latest"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# pnpm
set -gx PNPM_HOME "/Users/hoonyboom/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

