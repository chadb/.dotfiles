DOTFILES=.dotfiles
OLD=$HOME/${DOTFILES}/backup/`date  +%Y%m%d%H%M%S`

cd $HOME
mkdir -p $OLD

files=( .bash_profile .bashrc .bash_logout .ctags .gvimrc .signature .vim .vimrc .gitconfig .autotest .irbrc .pryrc .dir_colors .gemrc .screenrc .tmux.conf .tmuxinator .powconfig )

for file in ${files[*]}
do
    touch $file
    if [ -f $file ]; then
        echo "Saved $file in $OLD"
        cp $file $OLD
        ln -nfs $DOTFILES/$file $file 
    else 
        if [ -d $file ]; then
            cp -RH $file $OLD
            ln -nfs $DOTFILES/$file $file 
        fi
    fi
done

cd -
