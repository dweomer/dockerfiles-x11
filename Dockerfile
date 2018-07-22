FROM alpine:3.8

ARG XSERVER_GID=6000
ARG XSERVER_UID=${XSERVER_GID}
ARG XSERVER_HOME=/tmp

ENV DISPLAY=":0" \
    XINITRC="/etc/X11/xinit/xinitrc" \
    XSERVERRC="/usr/bin/X -ac -listen tcp" \
    XSERVER_BACKGROUND=/usr/share/X11/wallpaper.png

RUN set -x \
 && apk --no-cache add \
    dumb-init \
    feh \
    i3wm \
    pciutils \
    su-exec \
    xf86-input-evdev \
    xf86-input-keyboard \
    xf86-input-libinput \
    xf86-input-mouse \
    xf86-input-synaptics \
    xf86-input-vmmouse \
    xf86-video-ast \
    xf86-video-intel \
    xf86-video-vesa \
    xf86-video-vmware \
    xorg-server \
    xset \
 && addgroup -g ${XSERVER_GID} xserver \
 && adduser -D -G xserver -h ${XSERVER_HOME} -u ${XSERVER_UID} -S xserver \
 && X -version

COPY ./wallpaper.png ${XSERVER_BACKGROUND}
COPY ./xorg.conf.d/ /etc/X11/xorg.conf.d/
COPY ./xinitrc.d/ /etc/X11/xinit/xinitrc.d/
COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
