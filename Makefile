PROJECT_NAME := SampleApp
PROJECT_GIT_DIR := .

.PHONY: bootstrap
bootstrap:
	mint bootstrap
	cp -pR .githooks/* .git/hooks

.PHONY: gen-project
gen-project:
	find . -name "project.yml" -or -name "Package.swift" | xargs sed -i "" "s/SampleApp/$(PROJECT_NAME)/g"
	mint run xcodegen xcodegen generate --project ./App

.PHONY: open-project
open-project:	
	open ./App/$(PROJECT_NAME).xcodeproj

.PHONY: gen-mocks
gen-mocks:
	./scripts/gen-mocks.sh

.PHONY: format
format:
	./scripts/swiftformat.sh $(PROJECT_GIT_DIR)

.PHONY: lint
lint:
	./scripts/swiftlint.sh $(PROJECT_GIT_DIR)
