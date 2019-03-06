for docker_arch in amd64 arm32v6 arm64v8; do
  docker push adamhf/smashing:${docker_arch}-latest
done

docker manifest create --amend adamhf/smashing:latest adamhf/smashing:amd64-latest adamhf/smashing:arm32v6-latest adamhf/smashing:arm64v8-latest
docker manifest annotate adamhf/smashing:latest adamhf/smashing:arm32v6-latest --os linux --arch arm --variant v6
docker manifest annotate adamhf/smashing:latest adamhf/smashing:arm64v8-latest --os linux --arch arm64 --variant v8
docker manifest push adamhf/smashing:latest
