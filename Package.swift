// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "HD44780LCD",
    products: [
        .library(name: "HD44780LCD", targets: ["HD44780LCD"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "HD44780LCD",
            dependencies: [
                "SwiftyGPIO"
            ]
        )
    ]
)

