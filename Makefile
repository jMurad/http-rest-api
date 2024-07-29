.PHONY: build
build:
	# go build -v ./cmd/apiserver
	docker build -t http_rest_api_image .

start:
	docker compose down && docker compose up --build -d

stop:
	docker compose down

initilize:
	chmod ugo+x tools/initilize.sh && tools/./initilize.sh

.PHONY: postgres
postgres:
	docker run --name postgres -d -p 54331:5432 -e POSTGRES_PASSWORD=123456 postgres

migrate:
	migrate -path migrations -database "postgres://postgres:123456@localhost:5432/restapi_dev?sslmode=disable" -verbose up

migratelocal:
	migrate -path migrations -database "postgres://postgres:123456@localhost:54331/restapi_dev?sslmode=disable" -verbose up


.PHONY: test
test:
	go test -v -race -timeout 30s ./...

.DEFAULT_GOAL := build