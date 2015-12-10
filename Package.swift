import PackageDescription

let package = Package(
    name: "SimCtl",
    targets: [
      Target(name: "lol", dependencies: [.Target(name: "SimCtl")]),
    ],
    dependencies: [
      .Package(url: "https://github.com/neonichu/Chores", majorVersion: 0),
      .Package(url: "https://github.com/kylef/Commander", majorVersion: 0),
      .Package(url: "https://github.com/neonichu/Decodable", majorVersion: 0, minor: 3),
    ]
)
