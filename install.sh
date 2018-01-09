pip3 install --user pyuv powerline-status psutil pygit2
sudo apt install -y tmux zsh vim-nox libssl-dev libreadline-dev zlib1g-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
cd ~/.rbenv && src/configure && make -C src
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
wget -qO- https://get.haskellstack.org/ | sh

rm -Rf   ~/.vimrc                               # delete-link
rm -Rf   ~/.tmux.conf                           # delete-link
rm -Rf   ~/.zshrc                               # delete-link
rm -Rf   ~/.config/powerline                    # delete-link
rm -Rf   ~/.gitconfig                           # delete-link
rm -Rf   ~/.githelpers                          # delete-link
p=$(pwd)                                        # install-link
ln -sfn $p/vimrc        ~/.vimrc                # install-link
ln -sfn $p/tmux.conf    ~/.tmux.conf            # install-link
ln -sfn $p/zshrc        ~/.zshrc                # install-link
ln -sfn $p/powerline    ~/.config/powerline     # install-link
ln -sfn $p/gitconfig    ~/.gitconfig            # install-link
ln -sfn $p/githelpers   ~/.githelpers           # install-link
