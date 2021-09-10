############################
# STEP 1 build executable binary
############################
FROM alpine:latest AS builder
ENV RCLONE_VERSION=v1.56.0
WORKDIR /bin/
RUN wget https://github.com/ncw/rclone/releases/download/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-amd64.zip -O ./rclone.zip \ 
	&& unzip ./rclone.zip -d ./ \ 
	&& mv ./rclone-${RCLONE_VERSION}-linux-amd64/rclone ./rclone

############################
# STEP 2 build a small server image
############################
FROM alpine:latest
ENV BUCKET=rclone
ENV AUTH_USER=rclone
ENV AUTH_PASS=rclone123
ENV BASE_URL=/
ENV RC_USER=gui
ENV RC_PASS=gui123

RUN apk update \
	&& apk add --no-cache fuse \
	&& sed -i 's/#user_allow_other/user_allow_other/' /etc/fuse.conf

# cleanup
RUN rm -rf /tmp/* \
	&& rm -rf /var/tmp/* \
	&& rm -rf /var/cache/apk/*

COPY ./rclone.conf /root/.config/rclone/rclone.conf
COPY --from=builder /bin/rclone /rclone
WORKDIR /

# Run the server binary.
ENTRYPOINT /rclone -v --no-check-certificate --rc --rc-web-gui --rc-web-gui-no-open-browser --rc-user ${RC_USER} --rc-pass ${RC_PASS} --rc-addr :5572 --rc-serve serve webdav minio:${BUCKET} --disable-dir-list --vfs-cache-mode writes --addr :80 --user ${AUTH_USER} --pass ${AUTH_PASS} --baseurl ${BASE_URL}
EXPOSE 80
EXPOSE 5572
