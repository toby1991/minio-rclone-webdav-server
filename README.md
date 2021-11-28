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
* Password: `rclone123`

## Env Configuration
> Your Minio Bucket Name
```
BUCKET: rclone
```
> Your Webdav basic-auth username
```
AUTH_USER: rclone
```
> Your Webdav basic-auth password
```
AUTH_PASS: rclone123
```
> Your Webdav access base path, default "/", usually used for Webdav behind nginx/traefik
```
BASE_URL: /
```
> Your Rclone WebGUI username
```
RC_USER: gui
```
> Your Rclone WebGUI password
```
RC_PASS: gui123
```

## Dashboard
* Host: `http://127.0.0.1:5572`
* Username: `gui`
* Password: `gui123`

## Fuse
add `--cap-add SYS_ADMIN --device /dev/fuse --security-opt apparmor:unconfine` when running.
