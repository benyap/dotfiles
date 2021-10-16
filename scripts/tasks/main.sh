#!/bin/bash

# Execute relative to location of this file
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

# Load tasks
source setup_create_local_defaults.sh
source setup_default_shell.sh
source setup_file_associations.sh
source setup_git_tracking.sh
source setup_symlinks.sh
source setup_symlinks_post.sh
source setup_terminal_theme.sh
