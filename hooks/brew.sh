post_stow() {
    if [[ "${DRY_RUN:-0}" == "1" ]]; then
        echo "⏭️  Skipping Homebrew update and bundle install during dry run"
        return 0
    fi

    brew update
    brew bundle --file=~/.homebrew/Brewfile install
}
