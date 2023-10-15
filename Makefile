VERSION = 1.20.1
IMAGE = nicholasjackson/redstone

build_docker:
	cd Docker && docker build -t ${IMAGE}:${VERSION} .