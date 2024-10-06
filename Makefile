.DEFAULT_GOAL := all

########
# Global
########
.PHONY: all requirements deps test lint build clean
all: requirements deps test lint build
	@echo "INFO: All steps completed 🚀"

requirements: go golangci-lint goreleaser
	@echo "INFO: all required tools are installed"

deps: requirements
	go mod download
	go mod verify
	@echo "INFO: Dependencies are installed 📦"

test: requirements
	go mod tidy
	go test ./...
	@echo "INFO: Test are green ✔"

lint: requirements
	golangci-lint run --config .golangci.yml ./...
	@echo "INFO: Linted, well done 🦾"

build:
	goreleaser build --clean --skip validate
	@echo "INFO: OmniFeed are built 💾"

clean: requirements
	go clean
	rm -rf dist/
	@echo "INFO: Clean 🧹"

##############
# Requirements
##############
.PHONY: go golangci-lint goreleaser
# Install https://go.dev/doc/install
go: ; @which go > /dev/null

# Install https://goreleaser.com/install/
goreleaser: ; @which goreleaser > /dev/null

# Install https://golangci-lint.run/welcome/install/
golangci-lint: ; @which golangci-lint > /dev/null
