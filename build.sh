#!/usr/bin/env bash
set -e
docker run --rm --privileged multiarch/qemu-user-static:register --reset

for docker_arch in amd64 arm32v6 arm64v8; do
    case ${docker_arch} in
        amd64   ) qemu_arch="x86_64" ;;
        arm32v6 ) qemu_arch="arm" ;;
        arm64v8 ) qemu_arch="aarch64" ;;    
    esac
    wget -N https://github.com/multiarch/qemu-user-static/releases/download/v3.1.0-2/x86_64_qemu-${qemu_arch}-static.tar.gz
    tar -xvf x86_64_qemu-${qemu_arch}-static.tar.gz

    docker build \
      -f Dockerfile \
      --build-arg docker_arch=${docker_arch} \
      --build-arg qemu_arch=./qemu-${qemu_arch}-static \
      -t adamhf/smashing:${docker_arch}-latest \
      .    
done
