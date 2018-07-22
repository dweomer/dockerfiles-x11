#!/usr/bin/dumb-init /bin/sh
set -e
if [ ! -f ${XORG_CONF_FILE:='/etc/X11/xorg.conf.d/default.conf'} ]; then
    X -configure || true
    sed -e "s/modesetting/${GRAPHICS=modesetting}/g" < /root/xorg.conf.new > ${XORG_CONF_FILE}
fi
su-exec xserver:xserver xinit ${XINITRC} -- ${XSERVERRC} ${DISPLAY}
