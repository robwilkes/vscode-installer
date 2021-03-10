#!/usr/bin/env bash

if [ -z $1 ]; then
    echo "Package file not specific"
    echo "  install.sh code-stable-x64-xxxxxxxxxx.tar.gz"
    exit
fi

INSTALL_DIR="$HOME/.local/opt"

if [ ! -d "$HOME/.local" ]; then
	echo "Creating $HOME/.local"
	mkdir $HOME/.local
fi

if [ ! -d "$HOME/.local/opt" ]; then
	echo "Creating $HOME/.local/opt"
	mkdir $HOME/.local/opt
fi

if [ -d "$HOME/.local/opt/VSCode-linux-x64" ]; then
	echo "Removing previous installation dir - $HOME/.local/opt/VSCode-linux-x64"
	rm -rf $HOME/.local/opt/VSCode-linux-x64
fi

echo "Extracting to $HOME/.local/opt/"
tar zxvf $1 -C $HOME/.local/opt/ > /dev/null

if [ -f "$HOME/.local/share/applications/vscode.desktop" ]; then
	echo "Removing previous desktop shortcut - $HOME/.local/share/applications/vscode.desktop"
	rm $HOME/.local/share/applications/vscode.desktop
fi

echo "Creating .desktop shortcut $HOME/.local/share/applications/vscode.desktop"
cat << EOF > $HOME/.local/share/applications/vscode.desktop
[Desktop Entry]
Version=1.1
Type=Application
Name=Visual Studio Code
Exec=$HOME/.local/opt/VSCode-linux-x64/bin/code
Path=$HOME/.local/opt/VSCode-linux-x64/bin
Icon=$HOME/.local/opt/VSCode-linux-x64/resources/app/resources/linux/code.png
Terminal=false
EOF
