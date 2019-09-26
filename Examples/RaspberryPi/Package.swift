// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TestLCD",
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
        .package(url: "https://github.com/uraimo/HD44780CharacterLCD.swift.git",from: "3.0.0")
    ],
    targets: [
        .target(name: "TestLCD", 
                dependencies: ["SwiftyGPIO","HD44780LCD"],
                path: "Sources")
    ]
) 