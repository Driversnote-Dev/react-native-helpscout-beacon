import { NativeModules, Platform } from "react-native";

const { HelpscoutBeacon } = NativeModules;

export const HelpscoutBeaconModule = HelpscoutBeacon;

/**
 * Identify the user
 *
 * @param {String} email
 * @param {String} name
 */
const identify = (email, name = null) => {
  if (email === null) {
    console.error("[identify] Missing parameter: email");
    return;
  }
  if (Platform.OS === 'ios') {
      HelpscoutBeacon.identify(email, name);
  } else {
    if (name === null) {
        HelpscoutBeacon.identify(email);
      } else {
        HelpscoutBeacon.identifyWithEmailAndName(email, name);
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
const login = (email, name, userId) => {
  if (!email || !name || !userId) {
    console.error(
      "[login] Missing parameter. Either 'email', 'name', 'userId' or several of them are missing."
    );
    return;
  }
  identify(email, name);
  HelpscoutBeacon.addAttributeWithKey("userId", userId);
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
const loginAndOpen = (email, name, userId, signature = null) => {
  login(email, name, userId);
  if (signature === null) {
    HelpscoutBeacon.open(null);
  } else {
    HelpscoutBeacon.open(signature);
  }
};

/**
 * Display the Beacon user interface.
 *
 * @param {String} signature
 */
const open = (signature = null) => {
  if (signature === null) {
    HelpscoutBeacon.open(null);
  } else {
    HelpscoutBeacon.open(signature);
  }
}

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
const navigate = (path) => {
  if (!path) {
    console.error(
      "[navigate] Missing parameter: path"
    );
    return;
  }
  HelpscoutBeacon.navigate(path);
}

const HSBeacon = {
  init: HelpscoutBeacon.init,
  identify,
  login,
  loginAndOpen,
  open,
  navigate,
  logout: HelpscoutBeacon.logout,
  addAttributeWithKey: HelpscoutBeacon.addAttributeWithKey,
  openArticle: HelpscoutBeacon.openArticle,
  suggestArticles: HelpscoutBeacon.suggestArticles,
  resetSuggestions: HelpscoutBeacon.resetSuggestions
};

export default HSBeacon;
