post_stow() {
    if [[ "${DRY_RUN:-0}" == "1" ]]; then
        echo "⏭️  Skipping bat cache rebuild during dry run"
        return 0
    fi

    bat cache --build
}
