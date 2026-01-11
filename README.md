## personal dots

a few of the .config dirs i like to use across devices

```
# clone repo
git clone https://github.com/benalbone/dots.git ~/.config

# symlink .rc files
ln -s ~/.config/.zshrc ~/.zshrc
ln -s ~/.config/.zimrc ~/.zimrc
exec zsh

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install brew packages
brew bundle install --file "~/.config/Brewfile"

# restart shell
exec zsh
```
