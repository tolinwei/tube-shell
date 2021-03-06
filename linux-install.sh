#/bin/bash
# Define colors for prompt if terminal supports
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    NORMAL=""
fi

function println {
    echo "[" `date` "]" $1
}

function cprintln {
    echo -e "${YELLOW}[" `date` "]" $1 "${NORMAL}"
    if [ "$1" == "...Done" ]; then
        echo
    fi
}

echo -e "${YELLOW}
 _         _                     _
| |_ _   _| |__   ___     __   _(_)_ __ ___
| __| | | | '_ \\ / _ \\____\\ \\ / / | '_ \` _ \\
| |_| |_| | |_) |  __/_____\\ V /| | | | | | |
 \\__|\\__,_|_.__/ \\___|      \\_/ |_|_| |_| |_|${NORMAL}\n"

cprintln "[Start] Seting up tube-vim...\n"

cprintln "Defining directory variables..."
HOME_DIR=~
PROJECT_DIR=${HOME_DIR}/.tube-vim
PROJECT_THEME_DIR=${PROJECT_DIR}/themes
PROJECT_CONF_DIR=${PROJECT_DIR}/config
VIM_COLOR_DIR=${HOME_DIR}/.vim/colors
cprintln "...Done"


cprintln "Cloning repo to ${PROJECT_DIR}..."
rm -rf ${PROJECT_DIR}
git clone https://github.com/tolinwei/tube-shell.git ${PROJECT_DIR}
cprintln "...Done"


cprintln "Backing up & copying conf files for Bash, Vim and screen..."
date_time=`date +"%y_%m_%d_%H:%M"`
# For .bashrc
if [ -e ${HOME_DIR}/.bashrc ]; then
    println "Skipping .bashrc as it's existed..."
else
    println "Copying new .bashrc to ${HOME_DIR}..."
    cp ${PROJECT_CONF_DIR}/bashrc ${HOME_DIR}/.bashrc
fi

# For .vim/ and .vimrc
if [ -e ${HOME_DIR}/.vimrc ]; then
    println "Backing up ${HOME_DIR}/.vimrc to ${HOME_DIR}/.vimrc.bak-${date_time}..."
    mv ${HOME_DIR}/.vimrc ${HOME_DIR}/.vimrc.bak-${date_time}
fi
if [ -d ${HOME_DIR}/.vim ]; then
    println "Backing up ${HOME_DIR}/.vim/ folder to ${HOME_DIR}/.vim.bak-${date_time}..."
    mv ${HOME_DIR}/.vim ${HOME_DIR}/.vim.bak-${date_time}
fi
println "Copying new .vimrc to ${HOME_DIR}..."
cp ${PROJECT_CONF_DIR}/linux-vimrc ${HOME_DIR}/.vimrc

# For screen
if [ -e ${HOME_DIR}/.screenrc ]; then
    println "Backing up ${HOME_DIR}/.screenrc to ${HOME_DIR}/.screenrc.bak-${date_time}..."
    mv ${HOME_DIR}/.screenrc ${HOME_DIR}/.screenrc.bak-${date_time}
fi
println "Copying new .screenrc to ${HOME_DIR}..."
cp ${PROJECT_CONF_DIR}/screenrc ${HOME_DIR}/.screenrc

# For Vim color scheme – Gruvbox
println "Copying Vim color scheme – Gruvbox to ${VIM_COLOR_DIR}..."
mkdir -p ${VIM_COLOR_DIR}
cp ${PROJECT_THEME_DIR}/gruvbox.vim ${VIM_COLOR_DIR}
cprintln "...Done"


cprintln "Installing junegunn/vim-plug as Vim plugins manager..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cprintln "...Done"


cprintln "Installing Vim plugins defined in .vimrc..."
vim +PlugInstall +qa
cprintln "...Done"


cprintln "[End] Finish! Please restart your terminal emulator to enjoy!!"
echo -e "${YELLOW}
 _         _                     _
| |_ _   _| |__   ___     __   _(_)_ __ ___
| __| | | | '_ \\ / _ \\____\\ \\ / / | '_ \` _ \\
| |_| |_| | |_) |  __/_____\\ V /| | | | | | |
 \\__|\\__,_|_.__/ \\___|      \\_/ |_|_| |_| |_|${NORMAL}\n"

