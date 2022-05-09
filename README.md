# docker
docker script

Dockerfile이 있어도 실제 활용할 때는 다소 복잡한 면이 있습니다.
실제 Image를 구성하고 Container를 생성하는 것은, ip랑 port 설정 등이 포함되어 있기에 은근 귀찮습니다.

# Generate Image
Image를 간편히 생성

```
bash generate_image.sh --image_name $IMAGE_NAME
```

# Generate Container
Container를 image를 기반으로 생성
```
bash generate_container.sh --container_name $CONTAINER_NAME --image_name $IMAGE_NAME --port1 $PORT1 --port2 $PORT2
```
port1은 8888 port2는 6006을 기본으로 하는데 이미 점유되어 있다면 다른 포트 사용
