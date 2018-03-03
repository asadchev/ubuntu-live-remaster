#!/bin/bash

hostname localhost

export HOME=/root
export LC_ALL=C

# apt-get remove gnome-video-effects gnome-sudoku gnome-session-canberra gnome-mines gnome-mahjongg thunderbird-gnome-support language-pack-gnome-zh-hans* language-pack-gnome-pt* language-pack-gnome-fr* language-pack-gnome-es* language-pack-gnome-de* thunderbird 

echo "
deb http://archive.ubuntu.com/ubuntu/ xenial main restricted universe
deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe
" > /etc/apt/sources.list

apt update

apt install -y emacs24-nox
apt install -y clang
apt install -y openjdk-8-jre
apt install -y arduino arduino-mk
apt install -y gcc-avr gdb-avr avr-libc avrdude
apt install -y g++ gdb
apt install -y git cmake
apt install -y junior-programming
apt install -y python3 python-pygame python-matplotlib
apt install -y python-numpy
apt install -y nmap ssh telnet tcpdump wireshark-gtk can-utils
apt install -y android-sdk
apt install -y firefox
apt install -y vlc audacious pinta ffmpeg

add-apt-repository ppa:yannubuntu/boot-repair
apt-get update
apt-get install -y boot-repair

# add-apt-repository ppa:webupd8team/atom
# apt update
# apt install -y atom

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg |  apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list
apt update
apt install -y sublime-text

# Gnome flashback

apt install -y gnome-session-flashback

# cleanup

apt-get clean

# Change settings

sed 's/\#EXTRA_GROUPS=/EXTRA_GROUPS=/' -i /etc/adduser.conf
sed 's/\#ADD_EXTRA_GROUPS=/ADD_EXTRA_GROUPS=/' -i /etc/adduser.conf

rm -f /etc/skel/examples.desktop

echo 'export PYTHONSTARTUP="$HOME/.startup.py"' >> /etc/skel/.profile

cat << EOF > /etc/lightdm/lightdm.conf
[SeatDefaults]
allow-guest=true
greeter-show-manual-login=true
allow-user-switching=true
autologin-user=ubuntu
user-session=gnome-flashback-metacity
EOF


cat << EOF > /usr/share/gnome-panel/panel-default-layout.layout
[Toplevel bottom-panel]
expand=true
orientation=bottom
size=24
y-bottom=0

[Object menu-button]
object-iid=PanelInternalFactory::MenuButton
toplevel-id=bottom-panel
pack-index=0
pack-type=start

# [Object main-menu]
# object-iid=PanelInternalFactory::MainMenu
# toplevel-id=bottom-panel
# pack-index=0

[Object indicators]
object-iid=IndicatorAppletCompleteFactory::IndicatorAppletComplete
toplevel-id=bottom-panel
pack-type=end
pack-index=0

[Object window-list]
object-iid=WnckletFactory::WindowListApplet
toplevel-id=bottom-panel
pack-index=1

# [Object workspace-switcher]
# object-iid=WnckletFactory::WorkspaceSwitcherApplet
# toplevel-id=bottom-panel
# pack-type=end
# pack-index=0
EOF
