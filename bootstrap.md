1. install lightdm
2. configure wpa_supplicant and /etc/network/
3. install accountsservice
4. Autologin in lightdm

usbhid.mousepoll=0 to /boot/cmdline.txt

sudo apt-get purge wolfram-engine
sudo apt-get purge libreoffice*
sudo apt autoremove 
sudo apt-get clean
sudo apt-get install build-essential cmake pkg-config libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran libhdf5-dev libhdf5-serial-dev libhdf5-103 libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5 python3-dev python3-pip libjpeg-dev libtiff5-dev libjasper-dev libpng-dev  libilmbase-dev libopenexr-dev libgstreamer1.0-dev

```
sudo rm /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python
```

```
export WORKON_HOME=$HOME/virtenvs
export PROJECT_HOME=$HOME/Projects-Active
source /usr/local/bin/virtualenvwrapper.sh

```
to .bashrc

sudo pip install virtualenv virtualenvwrapper
sudo pip3 install virtualenv virtualenvwrapper
source ~/.bashrc
mkvirtualenv cv
workon cv
pip3 install opencv-contrib-python==4.1.0.25

sudo apt install lightdm accountsservice xterm xli

groupadd -r autologin
gpasswd -a pi autologin
groupadd -r nopasswdlogin
gpasswd -a pi nopasswdlogin

# install plymouth, set-default-theme