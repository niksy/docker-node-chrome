SHELL := /usr/bin/env bash

VERSION?=latest

.PHONY: build
build:
	docker buildx build --load . --tag niksy/node-chrome:$(VERSION)

.PHONY: release
release:
	docker buildx build --push --platform linux/amd64,linux/arm64 . --tag niksy/node-chrome:$(VERSION)
	make docs

.SILENT: docs
.PHONY: docs
docs:
	echo "Copying README.md to clipboard and opening edit page so you can update documentation…"
	sleep 3
	cat README.md | pbcopy
	open https://hub.docker.com/repository/docker/niksy/node-chrome/general
