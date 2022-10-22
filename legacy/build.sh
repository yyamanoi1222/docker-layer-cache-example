if [ $1 = "normal" ]; then
  echo "build normal"
  DOCKER_BUILDKIT=0 docker build -t layer-cache-example-legacy .
fi

if [ $1 = "cache-from-last" ]; then
  echo "build using cache-from only last"
  docker pull yyamanoi1222/layer-cache-example:latest || true
  DOCKER_BUILDKIT=0 docker build -t layer-cache-example-legacy --cache-from=yyamanoi1222/layer-cache-example:latest .

  docker tag layer-cache-example-legacy:latest yyamanoi1222/layer-cache-example:latest
  docker push yyamanoi1222/layer-cache-example:latest
fi

if [ $1 = "cache-from-full" ]; then
  echo "build using cache-from"
  docker pull yyamanoi1222/layer-cache-example:latest || true
  docker pull yyamanoi1222/layer-cache-example:builder || true

  DOCKER_BUILDKIT=0 docker build --target=builder -t yyamanoi1222/layer-cache-example:builder --cache-from=yyamanoi1222/layer-cache-example:builder .
  DOCKER_BUILDKIT=0 docker build -t yyamanoi1222/layer-cache-example:latest --cache-from=yyamanoi1222/layer-cache-example:builder --cache-from=yyamanoi1222/layer-cache-example:latest .

  docker push yyamanoi1222/layer-cache-example:latest
  docker push yyamanoi1222/layer-cache-example:builder
fi
