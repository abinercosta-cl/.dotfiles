#!/usr/bin/env bash
#
# Script de Bootstrap para Configuração do Ambiente Manjaro
#
# O que ele faz:
# 1. Instala apps essenciais e 'asdf-vm' via Pamac.
# 2. Cria links simbólicos para os dotfiles.
# 3. Limpa configurações manuais do asdf (o pacote AUR cuida disso).
# 4. Migra a configuração do Alacritty.
#

# --- Funções Auxiliares ---
log() {
  echo "🚀 [INFO] $1"
}

warn() {
  echo "⚠️  [AVISO] $1"
}

success() {
  echo "✅ [SUCESSO] $1"
}

fail() {
  echo "❌ [ERRO] $1"
  exit 1
}

# --- Variáveis de Caminho ---
# IMPORTANTE: Este script assume que seus dotfiles estão em ~/.dotfiles
# e os arquivos fonte estão em ~/.dotfiles/src
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_SRC_DIR="$DOTFILES_DIR/src"
CONFIG_DIR="$HOME/.config"
FISH_CONFIG_FILE="$CONFIG_DIR/fish/config.fish"

# --- PASSO 1: Instalar Pacotes Essenciais ---
log "Iniciando instalação de pacotes via Pamac..."
log "Isso pode pedir sua senha de administrador."

# Lista de pacotes dos seus dotfiles + dependências + asdf
# O Pamac (do Manjaro) pode instalar pacotes do repositório e do AUR
pacotes=(
  "alacritty"
  "starship"
  "fish"
  "helix"
  "git"
  "curl"
  "asdf-vm" 
)

pamac install ${pacotes[@]}

# Verifica se a instalação falhou
if [ $? -ne 0 ]; then
    fail "A instalação de pacotes falhou. Abortando."
fi

success "Pacotes instalados."

# --- PASSO 2: Configurar Links Simbólicos (Dotfiles) ---
log "Configurando links simbólicos dos dotfiles..."

# Garante que o diretório fonte existe
if [ ! -d "$DOTFILES_SRC_DIR" ]; then
    warn "Diretório $DOTFILES_SRC_DIR não encontrado."
    fail "Clone seus dotfiles para $DOTFILES_DIR primeiro."
fi

# Alacritty
mkdir -p "$CONFIG_DIR"
rm -rf "$CONFIG_DIR/alacritty.toml"
ln -sf "$DOTFILES_SRC_DIR/alacritty.toml" "$CONFIG_DIR/alacritty.toml"

# Starship
mkdir -p "$CONFIG_DIR"
rm -rf "$CONFIG_DIR/starship.toml"
ln -sf "$DOTFILES_SRC_DIR/starship.toml" "$CONFIG_DIR/starship.toml"

# Fish
mkdir -p "$CONFIG_DIR/fish"
rm -rf "$CONFIG_DIR/fish/config.fish"
ln -sf "$DOTFILES_SRC_DIR/config.fish" "$CONFIG_DIR/fish/config.fish"

# Helix
mkdir -p "$CONFIG_DIR/helix"
rm -rf "$CONFIG_DIR/helix/config.toml"
ln -sf "$DOTFILES_SRC_DIR/helix.toml" "$CONFIG_DIR/helix/config.toml"

success "Links simbólicos dos dotfiles criados."

# --- PASSO 3: Limpeza de Configuração (Idempotência) ---
log "Limpando o config.fish de entradas manuais desnecessárias..."
log "(O pacote 'asdf-vm' do AUR não precisa de 'source' manual)"

# Verifica se o config.fish (o link que acabamos de criar) existe
if [ -f "$FISH_CONFIG_FILE" ]; then
    # Remove qualquer linha de 'source' do asdf (método Git ou /opt)
    sed -i '/source ~\/.asdf\/asdf.fish/d' "$FISH_CONFIG_FILE"
    sed -i '/source \/opt\/asdf-vm\/asdf.fish/d' "$FISH_CONFIG_FILE"

    # Remove qualquer comando 'ln' de completions (que causa o erro "File exists")
    sed -i '/ln -s .*asdf.fish/d' "$FISH_CONFIG_FILE"
    
    success "config.fish limpo."
else
    warn "$FISH_CONFIG_FILE não encontrado. Pulando limpeza."
fi

# Remove o link de completions manual que criamos e que deu erro
# O pacote AUR instala isso em /usr/share/fish/vendor_completions.d/
COMPLETIONS_LINK="$CONFIG_DIR/fish/completions/asdf.fish"
if [ -L "$COMPLETIONS_LINK" ]; then # Verifica se é um link simbólico
    log "Removendo link de completions manual obsoleto..."
    rm "$COMPLETIONS_LINK"
fi

# --- PASSO 4: Migrar Configuração do Alacritty ---
log "Verificando migração do Alacritty..."

# O 'command -v' verifica se o comando existe
if command -v alacritty &> /dev/null; then
    alacritty migrate
    success "Configuração do Alacritty migrada."
else
    warn "Comando 'alacritty' não encontrado. Pulando migração."
fi

# --- Conclusão ---
echo ""
success "🎉 Ambiente configurado com sucesso!"
log "Feche e reabra seu terminal para aplicar todas as mudanças."
echo ""