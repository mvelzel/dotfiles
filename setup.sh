cd $HOME

# Setup GitHub ssh key
yes '' | ssh-keygen -t ed25519 -C "m.velzel@hotmail.com" -N ''
eval "$(ssh-agent -s)"
cat >$HOME/.ssh/config <<EOL
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
EOL
ssh-add $HOME/.ssh/id_ed25519
echo "Add the following key to GitHub:\n${cat $HOME/.ssh/id_ed25519.pub}"
read -p "Press enter to continue..."

# Clone the dotfiles
git clone git@github.com:mvelzel/dotfiles.git

# Set global .gitignore
ls -s $HOME/dotfiles/.global_gitignore $HOME/.gitignore
git config --global core.excludesFile '~/.gitignore'

# Install asdf
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.15.0

# Setup zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm $HOME/.zshrc ; ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
source $HOME/.zshrc

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Setup tmux
brew install tmux
[ -d "$HOME/.config" ] || mkdir $HOME/.config
ln -s $HOME/dotfiles/.config/tmux $HOME/.config/tmux
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Setup lazygit
brew install lazygit
ln -s $HOME/dotfiles/.config/lazygit $HOME/.config/lazygit

# Setup neovim and dependencies
brew install ripgrep
brew install neovim
ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim
