#!/bin/bash

# pre flight
#
mkdir ${HOME}/tmp > /dev/null 2>&1
sudo mkdir -p /usr/local/bin
sudo chown root:admin /usr/local
sudo chmod 2775 /usr/local /usr/local/bin
sudo chmod g+w /usr/local/share/man

# Mac preferences
#
# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Enable iTunes track notifications in the Dock
defaults write com.apple.dock itunes-notifications -bool true

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Disable window animations and Get Info animations in Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilte-stack -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
# defaults write com.apple.dock launchanim -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.Dock autohide-delay -float 0

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable auto-correct
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show item info below desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable tap to click (Trackpad)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Map bottom right Trackpad corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Disable the “reopen windows when logging back in” option
# This works, although the checkbox will still appear to be checked.
# defaults write com.apple.loginwindow TALLogoutSavesState -bool false
# defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# disable Dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES

for app in Safari Finder Dock SystemUIServer; do killall "$app" >/dev/null 2>&1; done

# babushka
#
babushka babushka

if [ $? != 0 ]; then
  bash -c "`curl babushka.me/up`"
fi

# ashmckenzie babushka deps
#
# if [ ! -d "${HOME}/.babushka/deps" ]; then
#   git clone git@github.com:ashmckenzie/babushka-deps.git ${HOME}/.babushka/deps
# else
#   cd ${HOME}/.babushka/deps
#   git reset --hard HEAD
#   git pull -r
# fi

if [ ! -d "${HOME}/.babushka/deps" ]; then
  exit 'ERROR: Make sure you symlink https://github.com/ashmckenzie/babushka-deps'
fi

# homebrew
#
babushka homebrew

# babushka app_bundle
#
babushka 'personal:ash-macbook-air'

# ruby 1.9.3 (via rbenv) / bundler
#
export PATH="${HOME}/.rbenv/bin:${PATH}"
eval "$(rbenv init -)"
babushka --update benhoskings:rbenv benhoskings:1.9.3-falcon.rbenv benhoskings:bundler.gem
rbenv global 1.9.3-falcon

# zsh
#
babushka benhoskings:zsh

# Dropbox symlinks
#
DROPBOX="${HOME}/Dropbox"
DHOME="${DROPBOX}/HOME"

for i in .ackrc .git_templates .gitconfig .gitignore_global .gvimrc .gvimrc.local .irbrc .lftprc .oh-my-zsh .pryrc .railsrc .rvmrc .ssh .vim .vimrc .vimrc.local .zsh .zsh-update .zshrc bin git
do
  ln -nfs ${DHOME}/${i} ${HOME}/
done

chmod 600 ${HOME}/.ssh/*

# Sublime Text 2
#
APPLICATION_SUPPORT="${HOME}/Library/Application Support"
for i in "Sublime Text 2" "Sublime Text 2/Backup" "Sublime Text 2/Backups" "Sublime Text 2/Settings"
do
  mkdir -p "${APPLICATION_SUPPORT}/${i}" > /dev/null 2>&1
done

ln -nfs "${DROPBOX}/Sublime Text 2/*" "${APPLICATION_SUPPORT}/Sublime Text 2/"

# Application Support
#
for i in Cyberduck Twitterrific
do
  ln -nfs "${DROPBOX}/${i}" ${HOME}/Library/Application\ Support/
done

# Preferences
#
for i in com.googlecode.iterm2.plist
do
  ln -nfs ${DROPBOX}/Preferences/${i} ${HOME}/Library/Preferences/
done

# homebrew stuff
#
brew tap adamv/alt
brew update

for i in coreutils gnu-sed hub pstree htop redis imagemagick ack
do
  installed=`brew info ${i} 2>&1 | grep -c 'Not installed'`
  if [ $installed != 0 ]; then
    brew install ${i}
  fi
done

brew install --HEAD htop

# sudo fix
#
sudo gsed -i 's/%admin\tALL=(ALL) ALL/%admin\tALL=(ALL) NOPASSWD:ALL/' /etc/sudoers

# Reminders
#
echo "** Don't forget to install Growl"
echo "** Don't forget to install the Xcode command line tools - http://kennethreitz.com/xcode-gcc-and-homebrew.html"
