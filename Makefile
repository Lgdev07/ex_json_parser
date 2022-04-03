.PHONY: $(MAKECMDGOALS)

OS_NAME := $(shell uname -s | tr A-Z a-z)
ifeq ($(OS_NAME),darwin)
OPEN = open
else
OPEN = xdg-open
endif

setup:
	docker-compose run --rm app mix deps.get

server:
	docker-compose up

console:
	docker-compose run --rm --service-ports app iex -S mix phx.server

test:
	docker-compose run --rm app mix test --cover

lint:
	docker-compose run --rm app mix format --check-formatted --dry-run

docs:
	docker-compose run --rm app mix docs && $(OPEN) doc/index.html
