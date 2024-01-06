PROJECT_NAME := SampleApp

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
	./scripts/swiftformat.sh

.PHONY: lint
lint:
	./scripts/swiftlint.sh

.PHONY: gen-mocks
gen-mocks:
	./gen-mocks.sh