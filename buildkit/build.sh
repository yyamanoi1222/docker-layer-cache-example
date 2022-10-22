if [ $1 = "normal" ]; then
  echo "build normal"
  docker buildx build -t layer-cache-example-buildkit .
fi

if [ $1 = "cache-from-last" ]; then
  echo "build using cache-from only last"
  docker buildx build \
    -t yyamanoi1222/layer-cache-example:latest \
    --cache-from=yyamanoi1222/layer-cache-example:latest \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    .
  docker push yyamanoi1222/layer-cache-example:latest
fi

if [ $1 = "cache-from-full" ]; then
  echo "build using cache-from"
  docker buildx build \
    -t yyamanoi1222/layer-cache-example:builder \
    --target=builder \
    --cache-from=yyamanoi1222/layer-cache-example:builder \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    .

  docker buildx build \
    -t yyamanoi1222/layer-cache-example:latest \
    --cache-from=yyamanoi1222/layer-cache-example:latest \
    --cache-from=yyamanoi1222/layer-cache-example:builder \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    .

  docker push yyamanoi1222/layer-cache-example:latest
  docker push yyamanoi1222/layer-cache-example:builder
fi

if [ $1 = "repository-min" ]; then
  docker buildx build \
    -t layer-cache-example-buildkit \
    --cache-to=type=registry,mode=min,ref=yyamanoi1222/layer-cache-example:cache \
    --cache-from=type=registry,ref=yyamanoi1222/layer-cache-example:cache \
    .
fi

if [ $1 = "repository-max" ]; then
  docker buildx build \
    -t layer-cache-example-buildkit \
    --cache-to=type=registry,mode=max,ref=yyamanoi1222/layer-cache-example:cache \
    --cache-from=type=registry,ref=yyamanoi1222/layer-cache-example:cache \
    .
fi

if [ $1 = "local-min" ]; then
  docker buildx build \
    -t layer-cache-example-buildkit \
    --cache-to=type=local,mode=min,dest=/tmp/docker_cache \
    --cache-from=type=local,src=/tmp/docker_cache \
    .
fi

if [ $1 = "local-max" ]; then
  docker buildx build \
    -t layer-cache-example-buildkit \
    --cache-to=type=local,mode=max,dest=/tmp/docker_cache \
    --cache-from=type=local,src=/tmp/docker_cache \
    .
fi
