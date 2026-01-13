// swift-tools-version: 6.0
@preconcurrency import PackageDescription

private extension PackageDescription.Target.Dependency {
  // static let factory: Self = .product(name: "Factory", package: "Factory")
}

private extension PackageDescription.Target.PluginUsage {
  // static let swiftGen: Self = .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
}

// ref. https://github.com/treastrain/swift-upcomingfeatureflags-cheatsheet
extension SwiftSetting {
  static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny") // SE-0335, Swift 5.6,  SwiftPM 5.8+
  static let internalImportsByDefault: Self = .enableUpcomingFeature("InternalImportsByDefault") // SE-0409, Swift 6.0,  SwiftPM 6.0+
}

let debugOtherSwiftFlags = [
  "-Xfrontend", "-warn-long-expression-type-checking=200",
  "-Xfrontend", "-warn-long-function-bodies=200",
  "-strict-concurrency=targeted",
  "-enable-actor-data-race-checks",
]

let package = Package(
  name: "SampleApp",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v18),
  ],
  products: [
    .library(
      name: "App",
      targets: ["App"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "App",
      dependencies: [
      ],
      swiftSettings: [.unsafeFlags(debugOtherSwiftFlags, .when(configuration: .debug))],
      plugins: [
      ]
    ),
    // .testTarget(
    //     name: "AppTests",
    //     dependencies: ["App"]
    // ),
    // .target(
    //     name: "Mocks",
    //     dependencies: [
    //     ],
    //     path: "./Tests/Mocks",
    //     exclude: [".gitkeep"]
    // ),
  ]
)

for target in package.targets {
  target.swiftSettings = [
    .unsafeFlags(debugOtherSwiftFlags, .when(configuration: .debug)),
    .existentialAny,
    .internalImportsByDefault,
  ]
}
