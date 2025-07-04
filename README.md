# benyap's dotfiles

## First time set up

Run the following command in your terminal in the HOME directory:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/benyap/dotfiles/main/install.sh)"
```

This will install the dotfiles in the `~/.dotfiles` directory.

## Managing the dotfiles

### Pulling in remote changes

Navigate to the `~/.dotfiles` directory and run the following commands:

```
git pull
./install.sh
```

### Making configuration changes

Make sure any configuration changes are made to the appropriate files,
and that running the install command (below) applies them idempotently.

```
./install.sh
```

The commit your changes in `git` and push to the remote.

