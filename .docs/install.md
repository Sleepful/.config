- MacOS
    * Download BetterDisplay
    * Max the key repeat (Settings>Keyboard)
    * Font
	    + Grab Iosevka Nerd Font from 
		    + https://www.nerdfonts.com/font-downloads
	    + Open Font Book on MacOS
	    + Then move the unzipped font folder into Font Book
    * Download Hammerspoon from official website
- Downloaded the `cfg` repo
	- installed kitty through curl command in kitty page
	- `brew install coreutils`
	- `brew install ripgrep`
	- `brew install flavours`
		- This is the most complicated install, do the following
		- `ln -s ~/.config/flavours ~/Library/Preferences/flavours`
			- necessary for flavours to find the nvim template or something like that
		- `cp .config/kitty/flavours.conf.base .config/kitty/flavours.conf && cp .config/nvim/colors/flavours.lua.base .config/nvim/colors/flavours.lua`
		- NOTE: if the `flavours` command hangs without exiting, restart computer to fix it
	- `brew install neovim`
	- `brew install fd`
	- `git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode`
	- `brew install tmux`
	- `brew install fzf`
	-
	- TODO..
		- hammerspoon
		- karabiner
		- tmux thumbs
