post_stow() {
    if [[ ! -d "~/.config/tmux/plugins/tpm" ]]; then
      echo "⏳ Cloning: tmux-plugins/tpm..."
      git clone "https://github.com/tmux-plugins/tpm" "~/.config/tmux/plugins/tpm"
      echo "✅ Cloned: tmux-plugins/tpm"
    else
      echo "🆗 Directory ~/.config/tmux/plugins/tpm already exists"
    fi
}
