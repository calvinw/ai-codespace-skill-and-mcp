IMAGE     = ghcr.io/calvinw/ai-course-devcontainer:latest
CONTAINER = ai-codespace
WORKSPACE = /workspaces/ai-codespace-skill-and-mcp

.PHONY: build run setup shell stop clean

## Pull image, start container, run setup, drop into shell
up: build run setup shell

## Pull the latest devcontainer image
build:
	docker pull $(IMAGE)

## Start the container with the repo mounted (detached)
run:
	docker run -d \
		--name $(CONTAINER) \
		-e CLAUDE_CODE_DISABLE_VSCODE_EXTENSION=1 \
		-e IS_SANDBOX=1 \
		-v "$(PWD)":$(WORKSPACE) \
		-w $(WORKSPACE) \
		$(IMAGE) \
		sleep infinity

## Run post-create setup inside the running container
setup:
	docker exec $(CONTAINER) bash .devcontainer/post-create.sh

## Open an interactive shell inside the container
shell:
	docker exec -it $(CONTAINER) bash

## Stop and remove the container
stop:
	docker stop $(CONTAINER) && docker rm $(CONTAINER)

## Stop, remove, and clean up everything
clean: stop
