post_stow() {
    if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
      echo "⏳ Cloning: tmux-plugins/tpm..."
      git clone "https://github.com/tmux-plugins/tpm" "$HOME/.config/tmux/plugins/tpm"
      echo "✅ Cloned: tmux-plugins/tpm"
    else
      echo "🆗 Directory $HOME/.config/tmux/plugins/tpm already exists"
    fi
}
