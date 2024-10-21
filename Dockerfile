FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

RUN echo 'root:123456' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 2286/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y emacs vim tmux apt python3-venv pandoc gdebi fonts-wqy-microhei python3-pip python3-virtualenv git
RUN python3 -m venv /opt/venv
RUN . /opt/venv/bin/activate && pip install pandas tabulate scipy bs4 markdown colorama openpyxl jinja2 markdown2

# For ARM machines
#RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_arm64.deb
#RUN gdebi -n wkhtmltox_0.12.6.1-2.jammy_arm64.deb

# For X86 machines
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb
RUN gdebi -n wkhtmltox_0.12.6.1-2.jammy_amd64.deb

RUN echo "source /opt/venv/bin/activate" >> /root/.bashrc
RUN echo "# apt-get install --reinstall ttf-mscorefonts-installer" >> /root/.bashrc
RUN apt-get install -y fontconfig
RUN apt-get install -y ttf-mscorefonts-installer

EXPOSE 2286

CMD ["/usr/sbin/sshd", "-D"]
