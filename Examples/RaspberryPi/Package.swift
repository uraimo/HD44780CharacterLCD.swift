import PackageDescription

let package = Package(
    name: "TestLCD",
    dependencies: [
        .Package(url: "https://github.com/uraimo/HD44780CharacterLCD.swift.git", majorVersion: 2),
    ]
)
