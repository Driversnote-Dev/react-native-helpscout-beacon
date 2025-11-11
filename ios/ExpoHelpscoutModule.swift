import ExpoModulesCore
import Beacon

public class ExpoHelpscoutModule: Module {
  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  public func definition() -> ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module. Takes a string as an argument.
    // Can be inferred from module's class name, but it's recommended to set it explicitly for clarity.
    // The module will be accessible from `requireNativeModule('ExpoHelpscout')` in JavaScript.
    Name("ExpoHelpscout")

      var helpscoutBeaconID: String? = nil
    var beaconUser: HSBeaconUser? = nil

    Function("init") { (beaconID: String?) in
      guard let beaconID = beaconID else {
        print("[init] missing parameter: beaconID")
        return
      }
      
      helpscoutBeaconID = beaconID
    }

    Function("identify") { (email: String?, name: String?) in
      guard let beaconID = helpscoutBeaconID else {
        print("[identify] Not initialized - did you forget to call 'init'?")
        return
      }

      guard let email = email else {
        print("[identify] missing parameter: email")
        return
      }

      let user = HSBeaconUser()
      user.email = email
      if let name = name {
        user.name = name
      }

      beaconUser = user
      HSBeacon.login(user)
    }


    Function("addAttributeWithKey") { (key: String?, value: String?) in
      guard let beaconID = helpscoutBeaconID else {
        print("[addAttributeWithKey] Not initialized - did you forget to call 'init'?")
        return
      }

      guard let user = beaconUser else {
        print("[addAttributeWithKey] Not initialized - did you forget to call 'identify' or 'login'?")
        return
      }

      guard let key = key, let value = value else {
        print("[addAttributeWithKey] missing parameters")
        return
      }

      user.addAttribute(withKey: key, value: value)
    }

    Function("open") { (signatureKey: String?) in
      guard let beaconID = helpscoutBeaconID else {
        print("[open] Not initialized - did you forget to call 'init'?")
        return
      }

      guard let _ = beaconUser else {
        print("[open] Not initialized - did you forget to call 'identify' or 'login'?")
        return
      }

      let settings = HSBeaconSettings(beaconId: beaconID)
      DispatchQueue.main.async {
        if let signature = signatureKey {
          HSBeacon.open(settings, signature: signature)
        } else {
          HSBeacon.open(settings)
        }
      }
    }


    Function("navigate") { (path: String?) in
      guard let beaconID = helpscoutBeaconID else {
        print("[navigate] Not initialized - did you forget to call 'init'?")
        return
      }

      guard let path = path else {
        print("[navigate] missing parameter: path")
        return
      }

      let settings = HSBeaconSettings(beaconId: beaconID)
      DispatchQueue.main.async {
        HSBeacon.navigate(path, beaconSettings: settings)
      }

    // MARK: - logout()
    Function("logout") {
      guard let _ = helpscoutBeaconID else {
        print("[logout] Not initialized - did you forget to call 'init'?")
        return
      }

      HSBeacon.logout()
    }

    // MARK: - openArticle(articleID, signature)
    Function("openArticle") { (articleID: String?, signature: String?) in
      guard let beaconID = helpscoutBeaconID else {
        print("[openArticle] Not initialized - did you forget to call 'init'?")
        return
      }

      guard let articleID = articleID else {
        print("[openArticle] missing parameter: articleID")
        return
      }

      let settings = HSBeaconSettings(beaconId: beaconID)
      DispatchQueue.main.async {
        if let signature = signature {
          HSBeacon.openArticle(articleID, beaconSettings: settings, signature: signature)
        } else {
          HSBeacon.openArticle(articleID, beaconSettings: settings)
        }
      }
    }

    Function("suggestArticles") { (articleIDList: [String]?) in
      guard let _ = helpscoutBeaconID else {
        print("[suggestArticles] Not initialized - did you forget to call 'init'?")
        return
      }

      guard let ids = articleIDList else {
        print("[suggestArticles] missing parameter: articleIDList")
        return
      }

      HSBeacon.suggest(ids)
    }

    Function("resetSuggestions") {
      guard let _ = helpscoutBeaconID else {
        print("[resetSuggestions] Not initialized - did you forget to call 'init'?")
        return
      }

      HSBeacon.suggest([])
    }
  }
}}
