# react-native-helpscout-beacon

Integrate the [Helpscout](https://www.helpscout.com/) Beacon into your React Native app.

* [**Android** SDK](https://developer.helpscout.com/beacon-2/android/)

    Current version: [2.3.1](https://github.com/helpscout/beacon-android-sdk-sample/blob/master/CHANGELOG.md#version-231-2020-12-21) (released 2020-12-21)

* [**iOS** SDK](https://developer.helpscout.com/beacon-2/ios/)

    Tested version: [2.0.2](https://github.com/helpscout/beacon-ios-sdk/blob/master/CHANGELOG.md#202-september-16-2020) (released 2020-09-16)

This library is compatible with and supported for React Native `v0.60+`.

## Installation

React Native `0.60` and above:

1. `$ yarn add react-native-helpscout-beacon`
2. Add `pod 'Beacon'` to your `Podfile`

For React Native `0.59` and below linking will be necessary (not tested): `$ react-native link react-native-helpscout-beacon`

## Update Helpscout SDK

### iOS

Can be updated in your main project directory by running

```bash
cd ios/ && pod update Beacon
```

### Android

Has to be updated in this module's `android/build.gradle`, i.e. the lines

```java
implementation "com.helpscout:beacon-core:2.0.1"
implementation "com.helpscout:beacon-ui:2.0.1"
```

## Usage example

```javascript
import HelpscoutBeacon from 'react-native-helpscout-beacon';

// init has to be called first
HelpscoutBeacon.init('my_helpscout_id');
// Login into your helpscout account
HelpscoutBeacon.login('email@address.com', 'John Smith', 'user_id_of_john_smith');
// Open the helpscout beacon (using a cryptographic signature)
HelpscoutBeacon.open('mySignature');
```

## Method description

Generally, please refer to the official docs for [ios](https://developer.helpscout.com/beacon-2/ios/) and [android](https://developer.helpscout.com/beacon-2/android/) for documentation on the following methods.

Not all methods of the SDKs are implemented so far.

### Methods

#### `init`

Initialize the Helpscout beacon library - has to be called before any other Helpscout method.

```javascript
HelpscoutBeacon.init('my_helpscout_id');
```

#### `identify`

Identify a helpscout user with `email` (and optional `name`)

```javascript
HelpscoutBeacon.identify('email@address.com', 'John Smith');
```

#### `logout`

Logout user from the Helpscout Beacon.

```javascript
HelpscoutBeacon.logout();
```

#### `addAttributeWithKey`

Used to add an user attribute represented as a key / value pair.
There is a limit of 30 attributes per user.

```javascript
HelpscoutBeacon.addAttributeWithKey('some_key', 'some_value');
```

#### `open`

Opens the Helpscout Beacon with Help Center articles.
The `init` and `login` methods will need to have been called before this will work.

May be used without arguments or with an optional `signature` ([secure mode](https://developer.helpscout.com/beacon-2/web/secure-mode/)).

```javascript
HelpscoutBeacon.open('my_signature');
```

#### `openArticle`

Opens the Helpscout Beacon at a specific Help Center article.
(Helpscout docs integration has to be enabled)

```javascript
HelpscoutBeacon.openArticle('some_article_id', 'my_signature');
```

#### `suggestArticles`

The suggestArticles method allows you to change the default list of suggested articles. Article IDs can be found in Help Scout by navigating to the article and copying the article ID from the URL. The URL is structured like this: `https://secure.helpscout.net/docs/[COLLECTION ID]/article/[ARTICLE ID]/`.
Custom suggestions will only get loaded when the Beacon is opened. If the Beacon is not present, loading the custom suggestion data will get queued up for the next Beacon display.

**Notes**:

* There is a limit of 5 article IDs. If the list is larger than 5 the additional articles will be ignored.
* The Helpscout docs integration has to be enabled for this method to work.

```javascript
const articleIDList = ['id1', 'id2', 'id3'];
HelpscoutBeacon.suggestArticles(articleIDList);
```

#### `resetSuggestions`

Reset any suggested articles set by `suggestArticles` back to Helpscouts own default suggestions.

```javascript
HelpscoutBeacon.openArticle('some_article_id', 'my_signature');
```

### Additional convenience methods

These methods are not part of the original SDKs but have proven to be useful.

#### `login`

Convenience method to identify the user via setting an attribute with key `userId`.

```javascript
HelpscoutBeacon.login('email@address.com', 'John Smith', 'user_id_of_john_smith');
```

It is equivalent to

```javascript
HelpscoutBeacon.identify('email@address.com', 'John Smith');
HelpscoutBeacon.addAttributeWithKey('userId', 'user_id_of_john_smith');
```

#### `loginAndOpen`

Convenience method to login via setting an attribute with key `userId` and opening the Helpscout beacon (with optional signature).

```javascript
HelpscoutBeacon.loginAndOpen('email@address.com', 'John Smith', 'user_id_of_john_smith', 'mySignature');
```