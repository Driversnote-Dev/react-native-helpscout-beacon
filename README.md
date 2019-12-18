# react-native-helpscout-beacon

Integrate the [Helpscout](https://www.helpscout.com/) Beacon into your React Native app.

* [**Android** SDK](https://developer.helpscout.com/beacon-2/android/)

    Current version: `2.0.1`

* [**iOS** SDK](https://developer.helpscout.com/beacon-2/ios/)

    Current version: `1.0.2`

This library is compatible with and supported for React Native `v0.60+`.

## Installation

React Native `0.60` and above:

1. `$ yarn add react-native-helpscout-beacon`
2. Add `pod 'Beacon'` to your `Podfile`

For React Native `0.59` and below linking will be necessary (not tested): `$ react-native link react-native-helpscout-beacon`


## Usage

```javascript
import HelpscoutBeacon from 'react-native-helpscout-beacon';

// init has to be called
HelpscoutBeacon.init('my_helpscout_id');
// Login into your helpscout account
HelpscoutBeacon.login('email@address.com', 'John Smith', 'some_attribute');
// Open the helpcenter (using a cryptographic signature)
HelpCenter.open('mySignature');
```
