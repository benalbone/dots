## personal dots

a few of the .config(s) i like to use across devices

```
# clone repo
git clone https://github.com/benalbone/dots.git $HOME/.config

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install brew packages
brew bundle install --file "$HOME/.config/Brewfile"

# symlink .rc files
ln -s $HOME/.config/.zshrc $HOME/.zshrc
ln -s $HOME/.config/.zimrc $HOME/.zimrc

# adjust shell prompt
sed -i "s/print -n '%#'/print -n '%(#.#.\$)'/g" $HOME/.zim/modules/asciiship/asciiship.zsh-theme
sed -i "" "/^PS1='$/{ N; s/PS1='\n/PS1='/; }" $HOME/.zim/modules/asciiship/asciiship.zsh-theme

# restart shell
exec zsh
```
