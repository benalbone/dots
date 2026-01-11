## personal dots

a few of the .config dirs i like to use across devices

```
# clone repo
git clone https://github.com/benalbone/dots.git ~/.config

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install brew packages
brew bundle install --file "~/.config/Brewfile"

# symlink .rc files
ln -s ~/.config/.zshrc ~/.zshrc
ln -s ~/.config/.zimrc ~/.zimrc

# adjust shell prompt
sed -i "s/print -n '%#'/print -n '%(#.#.\$)'/g" ~/.zim/modules/asciiship/asciiship.zsh-theme

# restart shell
exec zsh
```
