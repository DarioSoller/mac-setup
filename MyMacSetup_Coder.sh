# !/bin/sh
# Before executing this script make sure to have admin rights. Won't be fun otherwise!
# Make executable with : "chmod a+x MyMacSetup.sh"
# Run with: "./MyMacSetup.sh"
# Source: http://computers.tutsplus.com/tutorials/perfect-configurations-with-homebrew-and-cask--cms-20768




############################
# Basic OSX Setup and Infos
# from .osx dot file by Ayoze Barrera: https://github.com/ayozebarrera/dotfiles/blob/master/.osx
#
diskutil info disk0     # SSD Disk Info
read -p "Check the SSD specifications and press [Enter] to continue Mac Setup"
defaults write com.apple.LaunchServices LSQuarantine -bool false  # Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true  # Automatically quit printer app once the print jobs complete
sudo nvram SystemAudioVolume=" " # Disable the sound effects on boot
defaults write com.apple.universalaccess reduceTransparency -bool true # Disable transparency in the menu bar and elsewhere on Yosemite
#defaults write com.apple.CrashReporter DialogType -string "none"  # Disable the crash reporter
sudo systemsetup -setcomputersleep Off > /dev/null   # Never go into computer sleep mode
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1   # Check for software updates daily, not just once per week
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false  # Disable smart dashes as they’re annoying when typing code

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40   # Increase sound quality for Bluetooth headphones/headsets
defaults write NSGlobalDomain KeyRepeat -int 0   # Set a blazingly fast keyboard repeat rate
#launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null   # Stop iTunes from responding to the keyboard media keys
defaults write com.apple.screencapture disable-shadow -bool false    # Disable shadow in screenshots
defaults write com.apple.finder QuitMenuItem -bool true   # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder DisableAllAnimations -bool true  # Finder: disable window animations and Get Info animations

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

defaults write NSGlobalDomain AppleShowAllExtensions -bool true   # Finder: show all filename extensions
defaults write com.apple.finder ShowStatusBar -bool true    # Finder: show status bar
defaults write com.apple.finder ShowPathbar -bool true   # Finder: show path bar
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"   # When performing a search, search the current folder by default
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false    # Disable the warning when changing a file extension
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"   # Use list view in all Finder windows by default. Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder AppleShowAllFiles 1     # 1 = Show hidden Files & Folders, 0 = Hide hidden Files & Folders
killall Finder      # Restart Finder

defaults write com.apple.Safari UniversalSearchEnabled -bool false   # Privacy: don’t send search queries to Apple
defaults write com.apple.Safari SuppressSearchSuggestions -bool true    # Privacy: don’t send search queries to Apple
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true     # Show the full URL in the Safari address bar (note: this still hides the scheme)
defaults write com.apple.Safari HomePage -string "about:blank"    # Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false    # Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari ShowFavoritesBar -bool false     # Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ProxiesInBookmarksBar "()"    # Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true   # Enable Safari’s debug menu
defaults write com.apple.Safari IncludeDevelopMenu -bool true   # Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true   # Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true  # Enable the Develop menu and the Web Inspector in Safari
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true   # Add a context menu item for showing the Web Inspector in web views

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true   # Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TextEdit RichText -int 0   # Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit PlainTextEncoding -int 4    # Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4    # Open and save files as UTF-8 in TextEdit




###########################
# Install Xcode
# From AppStore first and accept license
read -p "Please install XCode via the Appstore, open it and accept all terms & conditions. If you are done with it, press [Enter] key to start continue Mac Setup Script..."
xcode-select --install      #xcode command line tool




###########################
# Install Ruby on Rails
# Source: http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/
#
#echo "gem: --no-document" >> ~/.gemrc       # RVM installs documentation for every gem that Rails depends on, which takes forever, I recommend disabling documentation first
#curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --autolibs=enable --rails       # Install Ruby on Rails
#brew doctor



###########################
# Setup SSH Default Identity
# Source: https://confluence.atlassian.com/pages/viewpage.action?pageId=270827678
#
ssh -v 			# check ssh install and version
ls -a ~/.ssh 	# check for existing ssh indentity
ssh-keygen -t ed25519		# ssh key generator start with the more secure SSH type ED25519
ls -a ~/.ssh 	# check for new ssh indentity files
pbcopy < ~/.ssh/id_ed25519.pub		# copy public key for saving it on the git server
read -p "Your Public SSH Key is copied to the clipboard. Please save it in your account of your git server. Press [Enter] key to start continue Mac Setup Script..."





###########################
# Install Homebrew
#
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile        # ensure that the path is set correctly
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor


###########################
# My Brew Packages
# ---
# Unused Brew Packages
#
#brew install wget
#brew install homebrew/dupes/tidy
#brew install homebrew/php/php56
#brew install homebrew/php56-xdebug
#brew install homebrew/php/phpsh
#brew install fish
#brew install ffmpeg
#brew install imagemagick

# Used Brew Packages
brew update
brew install git
which git              # should be "/usr/local/bin/git"
git --version
#git config --global user.name "Your Name"
#git config --global user.email "your@email.com"
brew install node
#brew install yarn
brew install caskroom/cask/brew-cask
brew doctor



############################
# Kubernetes & AWS
#
brew install kubernetes-cli
kubectl version
brew install aws-iam-authenticator
aws-iam-authenticator help
brew install awscli
#aws configure




############################
# My NPM Packages
#
#npm install -g yuicompressor	# used for PHPstorm's file watcher for CSS minifcation
#npm install -g uglify-js		# used for PHPstorm's file watcher for JS minifcation
#npm install -g less
#npm install -g bower
#npm install -g ember-cli

# Check, Fix or Generate ".editorconfig" files.
# Source: https://github.com/jedmao/eclint
# Usage for generation in the respective directory:
# 		eclint infer -i * "lib/**/*.js" > .editorconfig
# 		eclint infer -s * "lib/**/*.js" > editorconfig.json 
npm install -g eclint			





############################
# My Cask Packages
# ---
# Unused Cask Packages
#
#brew cask install aquamacs
#brew cask install textexpander
#brew cask install macvim
#brew cask install alfred
#brew cask install controlplane
# ---
#brew cask install retinacapture
#brew cask install quickcast
#brew cask install dash
#brew cask install teamviewer
#brew cask install hipchat
#brew cask install spacemonkey
#brew cask install google-drive
#brew cask install caffeine
#brew cask install vagrant-bar
#brew cask install reveal
#brew cask install xquartz #needed for inkscape
#brew cask install inkscape
#brew cask install cyberduck
#brew cask install rescuetime
#brew cask install appcleaner
#brew cask install cleanmymac
#brew cask install 1password
#brew cask install codekit
#brew cask install keka # un-/archive app
#brew cask install the-unarchiver # un-/archive app
#brew cask install coda
#brew cask install kid3
#brew cask install soundflower
#brew cask install handbrake
#brew cask install handbrakebatch
#brew cask install eclipse-ide
#brew cask install mactex
#brew cask install latexian
#brew cask install jdownloader
#brew cask install vox
#brew cask install flux
#brew cask install trim-enabler
#brew cask install sequel-pro
#brew cask install vlc
#brew cask install audacity
#brew cask install vagrant
#brew cask install vagrant-manager
#brew cask install virtualbox
#brew cask install java
#brew cask install mamp
#brew cask install sourcetree
#brew cask install sketch
#brew cask install dropbox
#brew cask install microsoft-office
#brew cask install phpstorm
#brew cask install skype
#brew cask install ccleaner
#brew cask install adobe-creative-cloud


#
# Used Cask Packages
#

brew cask install google-chrome
brew cask install firefox
brew cask install filezilla
brew cask install thunderbird
brew cask install toggldesktop
brew cask install sublime-text
brew cask install keepassx
brew cask install adobe-acrobat-reader
brew cask install openoffice
brew cask install xmind
brew cask install gimp
brew cask install docker
brew cask install kitematic
brew cask install disk-inventory-x
brew cask install spotify
brew cask install vox
brew cask install postman
brew cask install iterm2
brew cask install slack
brew cask install visual-studio-code
brew cask install fork





############################
# Clean up
#
brew cask cleanup
brew update
brew doctor
#brew upgrade 	# Update all brews to their latest version








