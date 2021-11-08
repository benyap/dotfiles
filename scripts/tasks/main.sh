#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

# Source files
source_all_sh_files_in_directory "install_apps_brew"
source_all_sh_files_in_directory "install_apps_mas"
source_all_sh_files_in_directory "install_core"
source_all_sh_files_in_directory "install_utilities"
source_all_sh_files_in_directory "setup"
source_all_sh_files_in_directory "setup_post"
