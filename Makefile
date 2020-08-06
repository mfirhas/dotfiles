.PHONY: all test build start run vendor clean

out=main

all: test build start

test:
	@go test -v -race ./...

compile:
	@go build -v ./...

build:
	@go build -o ./bin/app/${out} ./cmd/app/main.go

start:
	./bin/app/${out}

run:
	@go run ./cmd/app/main.go

vendor:
	@go mod vendor

clean:
	-rm -f ./${out}
	-rm -f ./main
	-rm -f ./bin/app/${out}

