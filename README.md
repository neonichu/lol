# SimCtl

[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

![This is fine.](fine.png)

Swift library and CLI for interacting with Xcode's `simctl`.

## Usage

You can list available simulators and their IDs:

```bash
$ ./.build/debug/lol list
Apple Watch - 38mm (EC1CD621-CA6A-4B6B-A20F-CF5EB4CB729D) (Shutdown)
Apple Watch - 42mm (0360D0A1-23B6-473B-90DD-DE55CD423D50) (Shutdown)
iPhone 4s (007ED883-185A-4663-893D-C8962AD46F35) (Shutdown)
iPhone 5 (BA83B1AD-7D82-47FE-A4BC-87BA34ECC168) (Shutdown)
```

You can also delete all simulators if Xcode has made a mess or you feel like it:

```bash
$ ./.build/debug/lol delete
```

Most importantly, you can recreate one simulator per runtime / device type combination
automatically, bringing you to a clean slate in conjunction with `delete`:

```bash
$ ./.build/debug/lol create_defaults
```

## Installation

SimCtl requires Swift 2.2, as it uses the [Swift Package Manager][1]. You can compile
it by just running:

```bash
$ make
```

By default, the CLI tool will be located in `.build/debug/lol`.

[1]: https://swift.org/package-manager/
