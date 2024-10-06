.DEFAULT_GOAL := all

########
# Global
########
.PHONY: all requirements build bake test lint deps clean
all: requirements deps test lint
	@echo "INFO: All steps completed 🚀"

requirements: go golangci-lint
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

clean: requirements
	go clean
	rm -rf dist/
	@echo "INFO: Clean 🧹"

##############
# Requirements
##############
.PHONY: go golangci-lint
go: ; @which go > /dev/null

golangci-lint: ; @which golangci-lint > /dev/null
