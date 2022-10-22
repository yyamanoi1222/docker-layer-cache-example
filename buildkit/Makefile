build-normal: clean
	sh build.sh normal

build-cache-from-last: clean
	sh build.sh cache-from-last

build-cache-from-full: clean
	sh build.sh cache-from-full

build-repo-min: clean
	sh build.sh repository-min

build-repo-max: clean
	sh build.sh repository-max

build-local-min: clean
	rm -rf /tmp/docker_cache
	sh build.sh local-min

build-local-max: clean
	rm -rf /tmp/docker_cache
	sh build.sh local-max

clean:
	docker builder prune -fa
	docker images --no-trunc --format '{{.ID}}' | xargs docker rmi || true
	docker images -a | grep layer-cache | awk '{print $3}' | xargs docker rmi || true
