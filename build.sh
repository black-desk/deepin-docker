#!/bin/bash

set -e

apt update

export DEBIAN_FRONTEND=noninteractive

apt install multistrap -y

multistrap -f apricot.multistrap || true

cp deepin.gpg /apricot-rootfs/etc/apt/trusted.gpg.d

multistrap -f apricot.multistrap

cp sources.list /apricot-rootfs/etc/apt/sources.list

echo 'export PATH="$PATH:/run/host/usr/local/bin:/run/host/usr/bin:/run/host/bin"' \
	>/apricot-rootfs/etc/profile.d/00-host-path.sh

{
	echo '/run/host/lib/x86_64-linux-gnu'
	echo '/run/host/usr/lib/x86_64-linux-gnu'
	echo '/run/host/lib'
	echo '/run/host/usr/lib'
} >>/etc/ld.so.conf.d/host-libs.conf
