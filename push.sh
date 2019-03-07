for docker_arch in amd64 arm32v6 arm64v8; do
  docker push mintel/smashing:${docker_arch}-latest
done

docker manifest create --amend mintel/smashing:latest mintel/smashing:amd64-latest mintel/smashing:arm32v6-latest mintel/smashing:arm64v8-latest
docker manifest annotate mintel/smashing:latest mintel/smashing:arm32v6-latest --os linux --arch arm --variant v6
docker manifest annotate mintel/smashing:latest mintel/smashing:arm64v8-latest --os linux --arch arm64 --variant v8
docker manifest push mintel/smashing:latest
