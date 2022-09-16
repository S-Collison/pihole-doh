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

for x in 0 1 6; do
	cd /etc/rc${x}.d && ln -s K01cloudflared ../init.d/cloudflared
done

for x in 2 3 4 5; do
	cd /etc/rc${x}.d && ln -s S01cloudflared ../init.d/cloudflared
done

EOF
