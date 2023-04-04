// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirestoreFirebase",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "FirestoreFirebase",
            targets: ["FirestoreFirebase"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.6.0"),
    ],
    targets: [
        .target(
            name: "FirestoreFirebase",
            dependencies: [
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestoreSwift", package: "firebase-ios-sdk"),
            ]
        ),
    ]
)
