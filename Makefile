.PHONY: all help build dep clean

MAKEFILE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

.DEFAULT_GOAL:= all

GO=GO111MODULE=on go
ROBINSON=${MAKEFILE_DIR}/cmd/robinson

NAME= robinsong
VERSION= 0.0.1

all: dep build

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## build binary
	@${GO} build -o "${NAME}" -ldflags '-X main.Version=${VERSION}' "${ROBINSON}" 

dep: ## install depndencies to vendor
	@${GO} mod vendor

clean: ## clean vendor and binary
	@rm -rf vendor "${NAME}"
