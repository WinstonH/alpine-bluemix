FROM alpine:edge
MAINTAINER Winston H.
# 设置中国时区
ENV TZ 'Asia/Shanghai'
RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo '${TZ}' > /etc/timezone \
    && rm -rf /var/cache/apk/*
# 导入edge最新源
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
# 安装桌面环境并添加用户alpine
RUN apk --update --no-cache add wget curl git x11vnc xvfb xrdp xauth alpine-desktop firefox-esr xfce4 ttf-freefont wqy-zenhei supervisor sudo openssl openssh dbus bash \
&& addgroup alpine \
&& adduser  -G alpine -s /bin/sh -D alpine \
&& echo "alpine:alpine" | /usr/sbin/chpasswd \
&& echo "alpine    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
&& rm -rf /tmp/* /var/cache/apk/*
# 使用entrypoint.sh，便于定制自己的镜像
COPY entrypoint.sh /usr/sbin/entrypoint.sh
ADD etc /etc
# 配置xrdp
RUN xrdp-keygen xrdp auto
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini \
&& sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini \
&& git clone https://github.com/novnc/noVNC.git \
&& ln -s /noVNC/vnc.html /noVNC/index.html

WORKDIR /home/alpine
EXPOSE 6080
USER alpine
ENTRYPOINT ["entrypoint.sh"]
