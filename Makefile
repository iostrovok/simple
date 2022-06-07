# Include go binaries into path
export PATH := $(GOPATH)/bin:$(PWD)/bin:$(PATH)

TEST_SOURCE_PATH=TEST_SOURCE_PATH=$(PWD)

install: mod ## Run installing
	@echo "Environment installed"

test: tests-someone tests-top

tests-someone: ## Run test covering
	cd ./someone/ && $(TEST_SOURCE_PATH) go test -coverprofile=$(PWD)/coverage-someone.out .
	go tool cover -html=coverage.out -o coverage-someone-buildtree.html
	rm coverage-someone.out

tests-top: ## Run test covering
	$(TEST_SOURCE_PATH) go test -coverprofile=$(PWD)/coverage.out .
	go tool cover -html=coverage.out -o coverage-buildtree.html
	rm coverage.out

#############################
#############################
#############################

clean-test: ## Remove vendor folder
	@echo "clean-test started..."
	rm -fr ./coverage*
	@echo "clean-test complete!"

clean-cache: ## Clean golang cache
	@echo "clean-cache started..."
	go clean -cache
	go clean -testcache
	@echo "clean-cache complete!"

clean-vendor: ## Remove vendor folder
	@echo "clean-vendor started..."
	rm -fr ./vendor
	@echo "clean-vendor complete!"

mod: ## Download all dependencies
	@echo "======================================================================"
	@echo "Run MOD...."

# 	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod verify
	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod tidy
	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod vendor
	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod download
# 	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod verify
	@echo "======================================================================"

clean-full: clean-vendor
	@echo "Run clean"
	go clean -i -r -x -cache -testcache -modcache
