FROM ubuntu:14.04.5

ENV DEBIAN_FRONTEND noninteractive
ENV USER root
ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8

# Timezone
RUN echo "$TZ" > /etc/timezone

# Desktop
RUN locale-gen zh_CN.UTF-8 \
&& apt-get update \
&& apt-get install -y --no-install-recommends ubuntu-desktop \
&& apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal \
&& apt-get install -y tightvncserver \
&& apt-get install -y openssh-server supervisor vim git curl wget firefox firefox-locale-zh-hans ttf-wqy-microhei libnet1-dev libpcap0.8-dev \
&& apt-get install -y language-pack-zh-hans-base language-pack-zh-hans language-pack-gnome-zh-hans language-pack-gnome-zh-hans-base \
&& mkdir /root/.vnc \
&& mkdir /var/run/sshd \
&& echo 'root:root' |chpasswd \
&& sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
&& apt-get clean

COPY supervisord.conf /etc/supervisord.conf
COPY vnc.sh /root/.vnc/vnc.sh
# Net-speeder
RUN git clone https://github.com/snooda/net-speeder.git net-speeder
WORKDIR net-speeder
RUN sh build.sh \
&& mv net_speeder /usr/local/bin/
# VNC config
ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd
# Cloud-torrent
RUN curl https://i.jpillora.com/cloud-torrent! | bash
# V2Ray
ENV PATH /usr/bin/v2ray:$PATH
RUN curl -sL https://install.direct/go.sh | bash
COPY config.json /etc/v2ray/config.json
# Finish
ADD entrypoint.sh /usr/sbin
RUN chmod 600 /root/.vnc/passwd \
&& chmod +x /usr/local/bin/net_speeder

WORKDIR /root

EXPOSE 21 22 80 8080 443 3306 3389 5901 8888 888 3000 10240
ENTRYPOINT ["entrypoint.sh"]
