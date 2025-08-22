#!/bin/bash

git clone https://github.com/asterisk/asterisk.git
cd asterisk

# Set up your environment
#----------------------------------
# Make sure you have necessary development tools and dependencies installed:
./contrib/scripts/install_prereq install

# Configure project with debug support
# ----------------------------------
# Run the configuration script enabling debug symbols and disabling optimizations:

./configure --enable-dev-mode
make menuselect.makeopts
menuselect/menuselect --disable-all --enable pbx_config menuselect.makedeps

make
make install # && make clean не выполнять, если нужно в дальнейшем быстро докомпилировать модули

echo -e "[modules]\nautoload = yes" | sudo tee -a /etc/asterisk/modules.conf
sudo cp configs/basic-pbx/extensions.conf /etc/asterisk/

asterisk -f
