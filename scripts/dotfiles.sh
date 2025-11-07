#!/bin/bash
# Script de dotfiles robusto

# Alacritty (direto em ~/.config)
rm -rf ~/.config/alacritty.toml
ln -sf ~/.dotfiles/src/alacritty.toml ~/.config/alacritty.toml

# Starship (direto em ~/.config)
rm -rf ~/.config/starship.toml
ln -sf ~/.dotfiles/src/starship.toml ~/.config/starship.toml

# Fish (precisa da pasta ~/.config/fish)
mkdir -p ~/.config/fish  # <-- ADICIONADO: Garante que a pasta existe
rm -rf ~/.config/fish/config.fish # <-- CORRIGIDO: O caminho do rm agora é igual ao do ln
ln -sf ~/.dotfiles/src/config.fish ~/.config/fish/config.fish

# Helix (precisa da pasta ~/.config/helix)
mkdir -p ~/.config/helix # <-- ADICIONADO: Garante que a pasta existe
rm -rf ~/.config/helix/config.toml
ln -sf ~/.dotfiles/src/helix.toml ~/.config/helix/config.toml

echo "✅ Dotfiles atualizados!"
