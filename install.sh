#!/usr/env sh

INSTALLDIR=$PWD

create_symlinks () {
    if [ ! -f ~/.vim ]; then
        echo "Now, we will create ~/.vim and ~/.vimrc files to configure Vim."
        ln -sfn $INSTALLDIR/vimified ~/.vim
    fi

    if [ ! -f ~/.vimrc ]; then
        ln -sfn $INSTALLDIR/vimified/vimrc ~/.vimrc
    fi
  }

if [ ! -d "$INSTALLDIR/vimified" ]; then
    echo "As we can't find Vimified in the current directory, we will create it."
    git clone https://github.com/snichme/vimified.git
    create_symlinks
    cd $INSTALLDIR/vimified

else
    echo "Seems like you already are one of ours, so let's update Vimified to be as awesome as possible."
    cd $INSTALLDIR/vimified
    git pull origin master
    create_symlinks
fi

if [ ! -d "bundle" ]; then
    echo "Now, we will create a separate directory to store the bundles Vim will use."
    mkdir bundle
    mkdir -p tmp/backup tmp/swap tmp/undo
fi

if [ ! -d "bundle/vundle" ]; then
    echo "Then, we install Vundle (https://github.com/gmarik/vundle)."
    git clone https://github.com/gmarik/vundle.git bundle/vundle
fi

vim +BundleInstall +qall 2>/dev/null

