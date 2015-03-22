git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

echo "Install VIM plugins"
vim -R +PluginInstall +qall > /tmp/vim_setup.log
echo "Install VIM plugins: done"
