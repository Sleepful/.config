docs for .cfg

https://www.atlassian.com/git/tutorials/dotfiles

creation:

```
git init --bare $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cfg cfg --local status.showUntrackedFiles no
echo "alias jfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc

```

clonation:

```
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore

git clone --bare <git-repo-url> $HOME/.cfg
git clone --bare git@github.com:Sleepful/.config.git $HOME/.cfg
git clone --bare https://github.com/Sleepful/.config.git $HOME/.cfg

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cfg checkout
cfg config --local status.showUntrackedFiles no
```
