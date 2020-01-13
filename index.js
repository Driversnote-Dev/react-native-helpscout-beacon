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
      `[login] Missing parameter. Either 'email', 'name', 'userId' or several of them are missing.`
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

const HSBeacon = {
  init: HelpscoutBeacon.init,
  identify,
  login,
  loginAndOpen,
  logout: HelpscoutBeacon.logout,
  addAttributeWithKey: HelpscoutBeacon.addAttributeWithKey,
  open: HelpscoutBeacon.open,
  openArticle: HelpscoutBeacon.openArticle,
  suggestArticles: HelpscoutBeacon.suggestArticles,
  resetSuggestions: HelpscoutBeacon.resetSuggestions
};

export default HSBeacon;
