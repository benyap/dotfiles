post_stow() {
    if [[ "${DRY_RUN:-0}" == "1" ]]; then
        echo "⏭️  Skipping asdf setup during dry run"
        return 0
    fi

    # Node.js
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest:24
    asdf install nodejs latest:26
    asdf set -u nodejs latest:26

    # Python
    # these brew packages are required to build Python from source
    brew install openssl@3 readline sqlite3 xz zlib
    asdf plugin add python https://github.com/asdf-community/asdf-python.git
    asdf install python latest:3
    asdf set -u python latest:3

    # Java
    asdf plugin add java https://github.com/halcyon/asdf-java.git
    asdf install java latest:openjdk
    asdf set -u java latest:openjdk
}

pre_unstow() {
    if [[ "${DRY_RUN:-0}" == "1" ]]; then
        echo "⏭️  Skipping asdf uninstall during dry run"
        return 0
    fi

    asdf list nodejs | sed 's/^[* ]*//' | xargs -n1 asdf uninstall nodejs
    asdf list python | sed 's/^[* ]*//' | xargs -n1 asdf uninstall python
    asdf list java | sed 's/^[* ]*//' | xargs -n1 asdf uninstall java
}
