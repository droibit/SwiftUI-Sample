# Project Overview

This repository is a SwiftUI-based sample iOS app. Use these instructions to guide code generation and edits that apply to the app itself.

## Environment & compatibility

- Xcode: 26 or later
- iOS deployment target: 18.0 or later
- Target Swift language level: Swift 6.0 or newer features are allowed and preferred.

## Language & concurrency

- Use Swift 6 language features where helpful.
- For asynchronous work, prefer Swift Concurrency APIs (async/await, `Task`, structured concurrency, `actor`). Do not introduce GCD or callback-based designs unless the user requests compatibility.

## Dependencies

- Manage dependencies with Swift Package Manager. If a change requires adding a package, update root `Package.swift` and explain why the dependency is necessary.

## Coding style & tooling

Follow the repository's style configuration when producing code:

- [.editorconfig](../.editorconfig)
- .swiftlint.yml (SwiftLint rules)
- .swiftformat (SwiftFormat rules)

Keep generated code consistent with those rules: indentation, line length, naming, import ordering. Make minimal formatting changes and avoid reformatting unrelated files.
