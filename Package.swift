// swift-tools-version: 6.2
@preconcurrency import PackageDescription

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

/// ref. https://github.com/treastrain/swift-upcomingfeatureflags-cheatsheet
extension SwiftSetting {
  static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny") // SE-0335, Swift 5.6,  SwiftPM 5.8+
  static let internalImportsByDefault: Self = .enableUpcomingFeature("InternalImportsByDefault") // SE-0409, Swift 6.0,  SwiftPM 6.0+
  static let memberImportVisibility: Self = .enableUpcomingFeature("MemberImportVisibility") // SE-0444, Swift 6.1,  SwiftPM 6.1+
  static let strictConcurrency: Self = .enableUpcomingFeature("StrictConcurrency")
  static let defaultActorIsolation: Self = .defaultIsolation(MainActor.self)
  static let nonisolatedNonsendingByDefault: Self = .enableUpcomingFeature("NonisolatedNonsendingByDefault") // SE-0461, Swift 6.2,  SwiftPM 6.2+
}

let debugOtherSwiftFlags = [
  "-Xfrontend", "-warn-long-expression-type-checking=200",
  "-Xfrontend", "-warn-long-function-bodies=200",
  "-enable-actor-data-race-checks",
]

for target in package.targets {
  guard !target.name.hasSuffix("Mocks") else {
    continue
  }

  target.swiftSettings = [
    .existentialAny,
    .internalImportsByDefault,
    .memberImportVisibility,
    .strictConcurrency,
    .defaultActorIsolation,
    .nonisolatedNonsendingByDefault,
    .unsafeFlags(debugOtherSwiftFlags, .when(configuration: .debug)),
  ]
}
