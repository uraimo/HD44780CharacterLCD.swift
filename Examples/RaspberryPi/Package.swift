import PackageDescription

let package = Package(
    name: "TestLCD",
    dependencies: [
        .package(url: "https://github.com/uraimo/HD44780CharacterLCD.swift.git", from: "3.0.0"),
    ]
)
