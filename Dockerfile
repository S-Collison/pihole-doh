# syntax=docker/dockerfile:1.3-labs
FROM pihole/pihole:latest

ADD cloudflared /etc/init.d/cloudflared

RUN <<EOF
ARCH="$(uname -m)"

if [ "$ARCH" == "aarch64" ]; then
	ARCH=arm64
fi

# install cloudflared
curl -L -o /usr/sbin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARCH
chmod 755 /usr/sbin/cloudflared

cd /etc/rc0.d && ln -s K01cloudflared ../init.d/cloudflared
cd /etc/rc1.d && ln -s K01cloudflared ../init.d/cloudflared
cd /etc/rc2.d && ln -s S01cloudflared ../init.d/cloudflared
cd /etc/rc3.d && ln -s S01cloudflared ../init.d/cloudflared
cd /etc/rc4.d && ln -s S01cloudflared ../init.d/cloudflared
cd /etc/rc5.d && ln -s S01cloudflared ../init.d/cloudflared
cd /etc/rc6.d && ln -s K01cloudflared ../init.d/cloudflared

EOF
