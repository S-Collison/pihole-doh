# syntax=docker/dockerfile:1.3-labs
FROM pihole/pihole:latest

ADD cloudflared /etc/services.d/cloudflared/

RUN <<EOF
ARCH="$(uname -m)"

if [ "$(uname -m)" == "aarch64" ]; then
	ARCH=arm64
fi

# install cloudflared
curl -L -o /usr/sbin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARCH
chmod 755 /usr/sbin/cloudflared
EOF
