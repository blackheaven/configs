pip3 install pyuv
pip3 install powerline-status
pip3 install psutil
pip3 install pygit2
sudo apt install tmux
sudo apt install zsh
sudo apt install vim-nox
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
cd ~/.rbenv && src/configure && make -C src
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

p=$(pwd)                                        # link
ln -sfn $p/vimrc        ~/.vimrc                # link
ln -sfn $p/tmux.conf    ~/.tmux.conf            # link
ln -sfn $p/zshrc        ~/.zshrc                # link
ln -sfn $p/powerline    ~/.config/powerline     # link
ln -sfn $p/gitconfig    ~/.config/gitconfig     # link
ln -sfn $p/githelpers   ~/.config/githelpers    # link
