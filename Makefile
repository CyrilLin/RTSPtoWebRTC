BIN_NAME = rtsp_proxy
VERSION=1.0

.PHONY: build clean run

GO=CGO_ENABLED=0 GO111MODULE=on go
GOCGO=CGO_ENABLED=1 GO111MODULE=on go

GOFLAGS=-ldflags "-X hcnow.cn/things/mds/${BIN_NAME}.Version=$(VERSION)"
GIT_SHA=$(shell git rev-parse HEAD)
ARCH=$(shell uname -m)

build: os/linux os/windows

os/linux:
	$(GOCGO) build $(GOFLAGS) -o ./bin/$(BIN_NAME) ./

os/windows:
	GOOS=windows $(GOCGO) build $(GOFLAGS) -o ./bin/$(BIN_NAME).exe ./

clean:
	rm -f ./bin/$(BIN_NAME)
	rm -f ./bin/$(BIN_NAME).exe