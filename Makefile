PROJECT_NAME := SampleApp
PROJECT_GIT_DIR := .

DEVICE_NAME := iPhone 17
OS_VERSION := 26.4

.PHONY: bootstrap
bootstrap:
	mint bootstrap

.PHONY: gen-project
gen-project:
	find . -name "project.yml" -or -name "Package.swift" | xargs sed -i "" "s/SampleApp/$(PROJECT_NAME)/g"
	mint run xcodegen xcodegen generate -s ./App/project.yml -p ./App

.PHONY: open-project
open-project:
	open ./App/$(PROJECT_NAME).xcodeproj

.PHONY: build-project
build-project:
	set -o pipefail && xcodebuild build \
	    -project ./App/$(PROJECT_NAME).xcodeproj \
	    -scheme $(PROJECT_NAME) \
	    -destination "platform=iOS Simulator,name=$(DEVICE_NAME),OS=$(OS_VERSION)" \
	  | xcbeautify

.PHONY: gen-mocks
gen-mocks:
	./scripts/gen-mocks.sh

.PHONY: format
format:
	./scripts/swiftformat.sh $(PROJECT_GIT_DIR)

.PHONY: lint
lint:
	./scripts/swiftlint.sh $(PROJECT_GIT_DIR)
