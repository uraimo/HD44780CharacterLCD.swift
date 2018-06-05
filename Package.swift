import PackageDescription

let package = Package(
    name: "HD44780LCD",
    dependencies: [
        .Package(url: "https://github.com/uraimo/SwiftyGPIO.git",
                 majorVersion: 1)
    ]
)
