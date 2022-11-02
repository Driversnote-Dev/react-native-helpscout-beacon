import { NativeModules, Platform } from 'react-native';
import { HelpScoutBeaconType } from './types';

export const HelpscoutBeaconModule = NativeModules.HelpscoutBeacon;

/**
 * Identify the user
 *
 * @param {String} email
 * @param {String} name
 */
const identify = (email: string, name?: string) => {
  if (email === null) {
    // console.error('[identify] Missing parameter: email');
    return;
  }
  if (Platform.OS === 'ios') {
    HelpscoutBeaconModule.identify(email, name);
  } else {
    if (name === undefined) {
      HelpscoutBeaconModule.identify(email);
    } else {
      HelpscoutBeaconModule.identifyWithEmailAndName(email, name);
    }
  }
};

/**
 * Convenience method to login via setting an attribute with key 'userId'
 *
 * @param {String} email
 * @param {String} name
 * @param {String} userId
 */
const login = (email: string, name: string, userId: string) => {
  if (!email || !name || !userId) {
    // console.error(
    //   "[login] Missing parameter. Either 'email', 'name', 'userId' or several of them are missing."
    // );
    return;
  }
  identify(email, name);
  HelpscoutBeaconModule.addAttributeWithKey('userId', userId);
};

/**
 * Convenience method to login via setting an attribute with key 'userId' and
 * opening the Helpscout beacon (with optional signature).
 *
 * @param {String} email
 * @param {String} name
 * @param {String} userId
 * @param {String} signature
 */
const loginAndOpen = (
  email: string,
  name: string,
  userId: string,
  signature?: string
) => {
  login(email, name, userId);
  if (signature === undefined) {
    HelpscoutBeaconModule.open(null);
  } else {
    HelpscoutBeaconModule.open(signature);
  }
};

/**
 * Display the Beacon user interface.
 *
 * @param {String} signature
 */
const open = (signature?: string) => {
  if (signature === undefined) {
    HelpscoutBeaconModule.open(null);
  } else {
    HelpscoutBeaconModule.open(signature);
  }
};

/**
 * Display a specific page in the Helpscout beacon. On Android, these paths
 * are supported:
 * - "/ask/message/"
 * - "/ask/chat/"
 * - "/answers/"
 *
 * iOS supports additional paths e.g. "/" which displays the initial state
 * of the beacon. Find supported path values here:
 * - https://developer.helpscout.com/beacon-2/ios/#navigate-to-a-specific-screen
 *
 * @param {String} path
 */
const navigate = (path: string) => {
  if (!path) {
    // console.error('[navigate] Missing parameter: path');
    return;
  }
  HelpscoutBeaconModule.navigate(path);
};

const HSBeacon = {
  init: HelpscoutBeaconModule.init as HelpScoutBeaconType['init'],
  identify,
  login,
  loginAndOpen,
  open,
  navigate,
  logout: HelpscoutBeaconModule.logout as HelpScoutBeaconType['logout'],
  addAttributeWithKey:
    HelpscoutBeaconModule.addAttributeWithKey as HelpScoutBeaconType['addAttributeWithKey'],
  openArticle:
    HelpscoutBeaconModule.openArticle as HelpScoutBeaconType['openArticle'],
  suggestArticles:
    HelpscoutBeaconModule.suggestArticles as HelpScoutBeaconType['suggestArticles'],
  resetSuggestions:
    HelpscoutBeaconModule.resetSuggestions as HelpScoutBeaconType['resetSuggestions'],
};

export default HSBeacon as HelpScoutBeaconType;
