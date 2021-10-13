#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_macos() {
  # Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
  osascript -e 'tell application "System Preferences" to quit'

  execute "_set_ui_defaults" "Set UI defaults"
  execute "_set_finder_defaults" "Set Finder defaults"
  execute "_set_activity_monitor_defaults" "Set Activity Monitor defaults"

  # Kill affected applications
  for app in \
    "cfprefsd" \
    "Activity Monitor" \
    "SystemUIServer" \
    "Dock" \
    "Finder";
  do
    killall "${app}" &> /dev/null
  done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

_set_ui_defaults() {
  # Reduce system transparency
  defaults write com.apple.universalaccess reduceTransparency -bool true

  # Expand save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  # Expand print panel by default
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  # Automatically quit printer app once the print jobs complete
  defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true

  # Only show scrollbars when scrolling
  defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
  # Possible values: `WhenScrolling`, `Automatic` and `Always`

  # Disable the “Are you sure you want to open this application?” dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
  sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

  # Disable “natural” scrolling
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
}

_set_finder_defaults() {
  # Set sidebar icons size to large
  defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 3

  # Show all file extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Show status bar in Finder
  defaults write com.apple.finder ShowStatusBar -bool true

  # Show path bar in Finder
  defaults write com.apple.finder ShowPathbar -bool true

  # Keep folders on top when sorting
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Disable the warning when changing a file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Avoid creating .DS_Store files on network or USB volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # Automatically open a new Finder window when a volume is mounted
  defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
  defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
  defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

  # Use column view in all Finder windows by default
  # Four-letter codes for view modes: 
  #   Flwv ▸ Cover Flow View
  #   Nlsv ▸ List View
  #   clmv ▸ Column View
  #   icnv ▸ Icon View
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

  # Show the ~/Library folder
  chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

  # Show the /Volumes folder
  sudo chflags nohidden /Volumes
}

_set_activity_monitor_defaults() {
  # Show the main window when launching Activity Monitor
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  # Visualize CPU usage in the Activity Monitor Dock icon
  defaults write com.apple.ActivityMonitor IconType -int 5

  # Show all processes in Activity Monitor
  defaults write com.apple.ActivityMonitor ShowCategory -int 0

  # Sort Activity Monitor results by CPU usage
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
