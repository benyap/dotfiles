post_stow() {
  # Install pi coding agent
  if [[ "${DRY_RUN:-0}" == "1" ]]; then
    echo "⏭️  Skipping Pi installation and update during dry run"
    return 0
  fi

  if ! command -v pnpm >/dev/null 2>&1; then
    echo "pnpm is required to install or update Pi" >&2
    return 1
  fi

  echo "⏳ Installing or updating Pi to the latest version..."
  pnpm add --global @earendil-works/pi-coding-agent@latest
}
