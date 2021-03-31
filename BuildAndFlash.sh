#!/bin/bash
rm -rf ./qmk_firmware
git clone --depth 1 git@github.com:SonixQMK/qmk_firmware.git 
# https://github.com/SonixQMK/qmk_firmware/tree/sn32_openrgb
cd ./qmk_firmware
git fetch
git checkout -b sn32_openrgb
git submodule update --init --recursive --depth 1
make redragon/k556 -j$(nproc --all)
cd ..
rm -rf ./sonix-flasher
git clone --depth 1 git@github.com:SonixQMK/sonix-flasher.git
# https://github.com/SonixQMK/sonix-flasher
cd ./sonix-flasher
python3 -m venv venv
. venv/bin/activate
pip install wheel
pip install -r requirements.txt
sudo fbs run
cd ..
sudo systemctl stop openrgb
rm -rf ./OpenRGB
git clone --depth 1 https://gitlab.com/CalcProgrammer1/OpenRGB.git --recursive
# https://gitlab.com/CalcProgrammer1/OpenRGB/-/tree/qmk_sonix
cd ./OpenRGB
git checkout -b qmk_sonix
qmake OpenRGB.pro
make -j$(nproc --all)
sudo systemctl start openrgb

