# benyap's dotfiles

This repository contains the configuration and tools that I use on a day to day
basis as a software developer. I made this mainly for my own safe-keeping and
for when I need to set up new environments, but feel free to take this and make
it your own.

This set up is currently tested for **macOS 11 Big Sur**. Compatability for
other versions of macOS (or other UNIX distributions) is not guaranteed.

## Installation

⚠️ **Warning**: If you want to give these dotfiles a try and decide to download
/ fork the scripts, you should review the code and remove anything you don't
want or don't understand before you install. Use at your own risk!

### Dependencies

- `bash`, `zsh` or `fish`: a shell to run commands in
- `curl`: to download stuff
- internet

### Download and install

Running the commands below will download the repository to `$HOME/.dotfiles` by
default (you will be given the option to customise this), then run the
`scripts/install.sh` script.

In `bash` or `zsh`:

```sh
bash <(curl -Ls https://raw.github.com/benyap/dotfiles/main/scripts/bootstrap.sh)
```

If you're using `fish`:

```sh
bash (curl -Ls https://raw.github.com/benyap/dotfiles/main/scripts/bootstrap.sh | psub)
```

### Manual steps

A couple of other useful things that I also do but couldn't figure out how to
automate with scripts:

- Install [Monosnap](https://monosnap.com/)
- Import [Raycast](https://raycast.com) configuration from
  `$HOME/.config/raycast/config.rayconfig`

### Updating

To update from the remote, simple do a `git pull` and run
`./scripts/install.sh`.

If you've made local changes, simply run `./scripts/install.sh`.

## Environment customisation

There are a few places where you can put things that need to be environment
specific or that should not tracked in `git`. They are:

- `home/.gitconfig.local` - useful for customising git for your environment (see
  `home/.gitconfig.local.template`)
- `home/.zshrc.local` - useful for customising `zsh`
- `home/.config/fish/config.fish.local` - useful for customising `fish`
- `home/.config/raycast/local` - useful for adding Raycast scripts that have
  sensitive information hardcoded

## What the scripts do

### Bootstrap - `bootstrap.sh`

Used to download and set up the dotfiles with zero dependencies. Like, you
literally only need a shell and `curl` which should be be installed already.

1. Source helper functions from `scripts/utils.sh`. If it doesn't exist,
   download it, then source it.
2. Check if the script was run inline (e.g. using the install command from this
   README). If it was, it'll download this repository as a zip and extract it so
   that it has all the other scripts available.
3. Run the `install.sh` script to do the rest of the work.

### Install - `install.sh`

Does the grunt work of setting everything up.

1. Source some utilities and helper functions - `scripts/utils.sh`.
2. Ask for `sudo` (and keeps the sudo state refreshed until the scripts finish).
3. Install core tools that are needed to install the rest of the stuff (XCode
   command line tools, git, Homebrew).
4. Set up the folder as a `git` repository so that any changes can be tracked.
5. Install utils / commands using Homebrew.
6. Install apps using Homebrew Cask.
7. Symlink configurations from the repository to where they should live in
   `$HOME`.
8. Set some opininated system configurations.

## If you want to fork this

There are a few spots where the setup / configs couldn't be "generalised", so it
may have my home directory (benyap) hardcoded. If you want to fork this and make
it your own, here are a few things you will need to do before you try to install
it on your machine:

- `scripts/bootstrap.sh` - set `REPOSITORY` variable to your own repository
- `scripts/install.sh` - set `REPOSITORY_ORIGIN` variable to your own
  repository's origin
- `home/.config/fish/fish_variables` - some of the variables have my home
  directory baked in, so you will need to rename these

And in case it wasn't obvious, the `home` directory in this project more or less
tries to mirror what would be symlinked to your actual home directory. It's
pretty easy to add more things you want to symlink - have a look at
`scripts/tasks/setup_symlinks.sh`.

## Check these out

These are some key repositories I drew inspiration (and maybe even "borrowed"
some code) from to build my own configuration. Lots of cool ideas in these.

- https://github.com/mathiasbynens/dotfiles
- https://github.com/caarlos0/dotfiles
- https://github.com/caarlos0/dotfiles.fish
- https://github.com/alrra/dotfiles
- https://github.com/gf3/dotfiles
- https://gist.github.com/shreeve/188ee4a8dff52d1000777364101c133d
- https://sourabhbajaj.com/mac-setup

## License

[MIT license](LICENSE). Feel free to use, or fork and make it your own.
