# Changelog

All notable changes to this project will be documented in this file.

_The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/)._

## [unreleased]

### Fixed

- Removed the use of jcenter for Android

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

[unreleased]: https://github.com/Driversnote-Dev/react-native-helpscout-beacon/compare/v0.4.0...master
[v0.4.0]: https://github.com/Driversnote-Dev/react-native-helpscout-beacon/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/Driversnote-Dev/react-native-helpscout-beacon/compare/v0.2.2...v0.3.0
