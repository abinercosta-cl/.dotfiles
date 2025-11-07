starship init fish | source
zoxide init fish | source
source ~/.asdf/asdf.fish

# Cria o diretório de completions do fish, se ele não existir
mkdir -p ~/.config/fish/completions

# Cria o link simbólico para o arquivo de completions do asdf
ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions/asdf.fish

alias cat bat
alias cd z
alias cp xcp
alias diff delta
alias eza_ 'eza --icons -s type --git'
alias find fd
alias grep rg
alias l 'eza_ -l --git-ignore'
alias la 'eza_ -la'
alias ls 'eza_ --git-ignore'
alias lsa 'eza_ --git-ignore'
alias lt 'eza_ -T --git-ignore'
alias lta 'eza_ -Ta --git-ignore -I .git'
alias rm rip
alias hx helix
