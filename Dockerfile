# syntax=docker/dockerfile:1.4
FROM pihole/pihole:latest

ADD etc/init.d/cloudflared /etc/init.d/cloudflared
#ADD service/run /etc/service/cloudflared/run
#ADD service/finish /etc/service/cloudflared/finish
COPY cloudflared/ /etc/s6-overlay/s6-rc.d/cloudflared/

RUN <<EOF
ARCH="$(uname -m)"

if [ "$ARCH" == "aarch64" ]; then
	ARCH=arm64
fi

# install cloudflared
curl -L -o /usr/sbin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARCH
chmod 755 /usr/sbin/cloudflared

touch /etc/s6-overlay/s6-rc.d/user/contents.d/cloudflared
cd /etc/rc0.d; ln -s ../init.d/cloudflared K01cloudflared
cd /etc/rc1.d; ln -s ../init.d/cloudflared K01cloudflared
cd /etc/rc2.d; ln -s ../init.d/cloudflared S01cloudflared
cd /etc/rc3.d; ln -s ../init.d/cloudflared S01cloudflared
cd /etc/rc4.d; ln -s ../init.d/cloudflared S01cloudflared
cd /etc/rc5.d; ln -s ../init.d/cloudflared S01cloudflared
cd /etc/rc6.d; ln -s ../init.d/cloudflared K01cloudflared

EOF
