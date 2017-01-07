#!/bin/bash

files=".Xresources .bashrc .tmux.conf"

home=~
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dirold="$( realpath $dir/../dotfiles_old )"

echo -e "These files: $files will be:\n - moved from $home to $dirold\n - replaced with symlinks to new dotfiles"
read -p "Press ENTER to continue, or CTRL+C to stop now"

mkdir -p $dirold

for file in $files; do
    mv $home/$file $dirold/$file
    echo " $home/$file -> $dir/$file"
    ln -sf $dir/$file $home/$file
done

. ~/.bashrc
echo -e ".bashrc reloaded\nOld files saved in $dirold"
