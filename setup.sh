#!/usr/bin/env sh

cd /root

apt update -y
apt upgrade -y
apt install -y emacs vim tmux apt pandoc gdebi fonts-wqy-microhei git curl default-jre cmake g++-14 ninja-build
apt install -y python3-venv python3-pip python3-virtualenv
python3 -m venv /opt/venv
. /opt/venv/bin/activate && pip install pandas tabulate scipy bs4 markdown colorama openpyxl jinja2 markdown2

apt-get install -y fontconfig
apt-get install -y ttf-mscorefonts-installer

apt-get install --reinstall ttf-mscorefonts-installer

# For ARM machines
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_arm64.deb
gdebi -n wkhtmltox_0.12.6.1-2.jammy_arm64.deb

# For X86 machines
#RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb
#RUN gdebi -n wkhtmltox_0.12.6.1-2.jammy_amd64.deb


git clone git@github.com:corvarx/dotfiles.git
cp /root/dotfiles/.emacs ~/
cp /root/dotfiles/.tmux.conf ~/

read -p "Enter your email address:" email
if [[ -z "$email" ]]; then
    echo "Email address cannot be empty."
    exit 1
fi

git config --global user.name "Yuejian Xie"
git config --global user.email "$email"
echo "git email has been set to: $email"

echo "source /opt/venv/bin/activate" >> ~/.bashrc
echo "alias em='emacs -nw'" >> ~/.bashrc
