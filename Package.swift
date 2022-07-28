// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    // 1. Название нашего пакета
    name: "GDFirebase",
    // 2. Платформы, которые поддерживаются нашим пакетом
    platforms: [
        .iOS(.v11),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GDFirebase",
            targets: ["GDFirebase"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
//        .package(url : "https://github.com/firebase/firebase-ios-sdk.git",
//                 from: "9.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.10.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GDFirebase",
            dependencies: [
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
            ]
        ),
    ]
)
