build-normal: clean
	sh build.sh normal

build-cache-from-last: clean
	sh build.sh cache-from-last

build-cache-from-full: clean
	sh build.sh cache-from-full

clean:
	docker builder prune -fa
	docker images --no-trunc --format '{{.ID}}' | xargs docker rmi || true
	docker images -a | grep layer-cache-example | awk '{print $3}' | xargs docker rmi || true
