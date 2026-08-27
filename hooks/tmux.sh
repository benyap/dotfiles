post_stow() {
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"

    if [[ "${DRY_RUN:-0}" == "1" ]]; then
      echo "⏭️  Skipping tmux plugin setup during dry run"
      return 0
    fi

    if [[ ! -d "$tpm_dir" ]]; then
      echo "⏳ Cloning: tmux-plugins/tpm..."
      git clone "https://github.com/tmux-plugins/tpm" "$tpm_dir"
      echo "✅ Cloned: tmux-plugins/tpm"
    else
      echo "🆗 Directory $HOME/.config/tmux/plugins/tpm already exists"
    fi

    if ! command -v tmux >/dev/null 2>&1; then
      echo "⚠️  tmux is not installed; skipping plugin installation"
      return 0
    fi

    echo "⏳ Installing tmux plugins..."
    tmux source-file "$HOME/.config/tmux/tmux.conf"
    "$tpm_dir/bin/install_plugins"
    echo "✅ Installed tmux plugins"
}
