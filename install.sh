#!/bin/bash

# For testing
home=~

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
files=".Xresources .bashrc .tmux.conf"

echo "These files will be overriden: $files, in $home"
read -p "Press ENTER to continue, or CTRL+C to stop now"

for file in $files; do
    echo "  $home/$file"
    ln -sf $dir/$file $home/$file
done
