# minio-rclone-webdav-server

A @rclone served WebDAV server with @minio as the s3 storage backend docker example

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/toby1991/rclone-webdav.svg)

## Run
```bash
git clone https://github.com/toby1991/minio-rclone-webdav-server
cd minio-rclone-webdav-server
docker-compose up -d
```

Then use your favorite WebDAV connect:
* Host: `http://127.0.0.1:80`
* Username: `rclone`
* Password `rclone123`

## Fuse
add `--cap-add SYS_ADMIN --device /dev/fuse --security-opt apparmor:unconfine` when running.
