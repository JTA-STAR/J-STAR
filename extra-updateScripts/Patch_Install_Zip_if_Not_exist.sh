#!/bin/bash
#  
# sudo curl https://www.bi7jta.cn/files/AndyTaylorTweet/updateScripts/Patch_Install_Zip_if_Not_exist.sh | sudo sh 

echo "Check if 'zip' is already installed"
if ! command -v zip &> /dev/null
then
    echo "zip tool is not installed, installing..."

    # Use package manager to install zip
    sudo apt update
    sudo apt install -y zip

    # Check if the installation was successful
    if command -v zip &> /dev/null
    then
        echo "zip tool installed successfully."
    else
        echo "Installation failed. Please install the zip tool manually."
        exit 0  #表示脚本正常结束，没有发生错误。
    fi
else
    echo "zip tool is already installed."
fi
