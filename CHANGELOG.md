# Changelog

All notable changes to this project will be documented in this file.

_The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/)._

## [unreleased]

## [v0.6.0] - 2022-11-03

### Changed

- Android native SDK is updated to v. 5.1.2
- iOS native SDK is updated to v. 3.0.1
- `package.json` is now pointing to the right index and types file
- Podspecs now include `Beacon` as dependency

## [v0.5.0] - 2022-11-03

### Fixed

- Removed the use of jcenter for Android

### Changed

- Android native SDK is updated to v. 4.1.0

### Added

- Typescript support

## [v0.4.0] - 2021-07-08

### Added

- Added `navigate` API method, by [@martinpoulsen](https://github.com/martinpoulsen) (see [#8](https://github.com/Driversnote-Dev/react-native-helpscout-beacon/pull/8))

## [v0.3.0] - 2021-01-14

### Added

- Allow `HelpscoutBeacon.open` to be called in basic mode (non [secure mode](https://developer.helpscout.com/beacon-2/web/secure-mode/)), i.e. without encrypted `signature`, by [@andrekovac](https://github.com/andrekovac) (see [#6](https://github.com/Driversnote-Dev/react-native-helpscout-beacon/pull/6))

### Changed

- _Android_: Upgrade HelpScout Beacon SDK to version 2.3.1, by [@andrekovac](https://github.com/andrekovac) (see [#6](https://github.com/Driversnote-Dev/react-native-helpscout-beacon/pull/6))

[unreleased]: https://github.com/Driversnote-Dev/react-native-helpscout-beacon/compare/v0.5.0...master
[v0.5.0]: https://github.com/Driversnote-Dev/react-native-helpscout-beacon/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/Driversnote-Dev/react-native-helpscout-beacon/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/Driversnote-Dev/react-native-helpscout-beacon/compare/v0.2.2...v0.3.0
