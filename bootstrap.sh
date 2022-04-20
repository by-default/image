usbhid.mousepoll=0 to /boot/cmdline.txt

sudo apt-get purge wolfram-engine
sudo apt-get purge libreoffice*
sudo apt autoremove 
sudo apt-get clean
sudo apt-get install build-essential cmake pkg-config \
libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
libxvidcore-dev libx264-dev libfontconfig1-dev libcairo2-dev \
libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev \
libatlas-base-dev gfortran libhdf5-dev libhdf5-serial-dev \
libhdf5-103 libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5 \
python3-dev python3-pip libjpeg-dev libtiff5-dev libjasper-dev \
libpng-dev  libilmbase-dev libopenexr-dev libgstreamer1.0-dev

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

touch ~/.hushlogin

# /etc/systemd/system/getty@tty1.service.d/autologin.conf
'''
[Service]
ExecStart=
ExecStart=-/sbin/agetty --skip-login --noclear --noissue --login-options "-f pi" %I $TERM
'''

sudo apt install chromium omxplayer vlc xdotool imagemagick ntpdate git

# update plymouth
sudo apt install libudev-dev libdrm-dev xsltproc
git clone https://gitlab.freedesktop.org/plymouth/plymouth.git
cd plymouth/
./autogen.sh
./configure --disable-documentation
make
cd ..
sudo make install
# copy a theme
sudo plymouth-set-default-theme bydefault
rm -rf plymouth/

sudo apt install golang libasound2-dev
git clone https://github.com/sqshq/sampler.git
cd sampler/
go build
sudo mv sampler /usr/bin/
cd ..
rm -rf sampler
sudo rm -rf go

pip3 install netifaces
sudo systemctl enable bydefault.service
sudo systemctl enable create-data.service
sudo systemctl enable dashboard.service

sudo apt install screen
sudo ntpdate -s time.nist.gov
curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli join <network>

sudo apt install cups
sudo usermod -a -G lpadmin pi
#edit conf
sudo service cups restart
sudo lpinfo -v
sudo lpadmin -p $PRINTER_NAME -v "$PRINTER_URI" -P $PPD_FILE -E # https://www.openprinting.org/driver/cdnj500

# AP


sudo apt install avahi-utils

# tests
1. boot up
2. creating and mounting data partition
3. run chrome, check webgl
4. running apt upgrade
4. check glxgears
5. run omxplayer, video and audio
6. omxplayer-sync

# chromium --kiosk --use-fake-ui-for-media-stream /data/ga-mimicry-cam.html
# chromium --kiosk --start-fullscreen --incognito --noerrdialogs --disable-translate --no-first-run --disable-infobars --window-position=0,0 --window-size=1920,1100
