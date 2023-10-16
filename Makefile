VERSION = 1.20.1
IMAGE = nicholasjackson/redstone

build_docker:
	cd Docker && docker build -t ${IMAGE}:${VERSION} .

run_docker:
	docker run \
		-it \
		--rm	\
		-p 8080:8080 \
		-p 9191:9191 \
		-p 25565:25565 \
		-v "$(shell pwd)/Docker/world:/minecraft/world" \
		-v "$(shell pwd)/Docker/config:/minecraft/config" \
		-e ONLINE_MODE=false \
		-e WHITELIST_ENABLED=false \
		-e RCON_PASSWORD=secret \
		-e RCON_ENABLED=true \
		${IMAGE}:${VERSION}