package expo.modules.helpscout

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import java.net.URL
import android.text.TextUtils
import android.util.Log
import android.content.Context
import com.helpscout.beacon.Beacon
import com.helpscout.beacon.ui.BeaconActivity
import com.helpscout.beacon.model.BeaconScreens
import com.helpscout.beacon.model.SuggestedArticle


class ExpoHelpscoutModule : Module() {
  private val TAG = "com.driversnote.helpscoutbeacon"
  private var beacon: Beacon? = null

  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  override fun definition() = ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module. Takes a string as an argument.
    // Can be inferred from module's class name, but it's recommended to set it explicitly for clarity.
    // The module will be accessible from `requireNativeModule('ExpoHelpscout')` in JavaScript.
    Name("ExpoHelpscout")

    Function("init") { beaconID: String? ->
      if (beaconID.isNullOrEmpty()) {
        Log.w(TAG, "[init] Missing argument: beaconID")
        return@Function
      }
      beacon = Beacon.Builder()
        .withBeaconId(beaconID)
        .build()
    }

    Function("identify") { email: String?, name: String? ->
      if (beacon == null || email.isNullOrEmpty() || name.isNullOrEmpty()) {
        if (beacon == null) Log.w(TAG, "[identifyWithEmailAndName] Not initialized - did you forget to call 'init'?")
        if (email.isNullOrEmpty()) Log.w(TAG, "[identifyWithEmailAndName] Missing argument: email")
        if (name.isNullOrEmpty()) Log.w(TAG, "[identifyWithEmailAndName] Missing argument: name")
        return@Function
      }
      Beacon.identify(email, name)
    }

    Function("logout") {
      if (beacon == null) {
        Log.w(TAG, "[logout] Not initialized - did you forget to call 'init'?")
        return@Function null
      }
      Beacon.logout()
      null
    }

    Function("addAttributeWithKey") { key: String?, value: String? ->
      if (beacon == null || key.isNullOrEmpty() || value.isNullOrEmpty()) {
        if (beacon == null) Log.w(TAG, "[addAttributeWithKey] Not initialized - did you forget to call 'init'?")
        if (key.isNullOrEmpty()) Log.w(TAG, "[addAttributeWithKey] Missing argument: key")
        if (value.isNullOrEmpty()) Log.w(TAG, "[addAttributeWithKey] Missing argument: value")
        return@Function
      }
      Beacon.addAttributeWithKey(key, value)
    }

    Function("open") { signature: String? ->
      if (beacon == null) {
        Log.w(TAG, "[open] Not initialized - did you forget to call 'init'?")
        return@Function
      }
      val context = appContext.reactContext ?: return@Function
      if (signature.isNullOrEmpty()) {
        BeaconActivity.open(context)
      } else {
        BeaconActivity.openInSecureMode(context, signature)
      }
    }
//
    Function("openArticle") { articleID: String?, signature: String? ->
      if (beacon == null || articleID.isNullOrEmpty()) {
        if (beacon == null) Log.w(TAG, "[openArticle] Not initialized - did you forget to call 'init'?")
        if (articleID.isNullOrEmpty()) Log.w(TAG, "[openArticle] Missing argument: articleID")
        return@Function
      }

      val context = appContext.reactContext ?: return@Function
      val articleList = arrayListOf(articleID)

      if (signature.isNullOrEmpty()) {
        BeaconActivity.open(context, BeaconScreens.ARTICLE_SCREEN, articleList)
      } else {
        BeaconActivity.openInSecureMode(context, signature, BeaconScreens.ARTICLE_SCREEN, articleList)
      }
    }

    Function("navigate") { path: String? ->
      if (beacon == null) {
        Log.w(TAG, "[navigate] Not initialized - did you forget to call 'init'?")
        return@Function
      }

      val context = appContext.reactContext ?: return@Function
      when (path) {
        "/ask/message/" -> BeaconActivity.open(context, BeaconScreens.CONTACT_FORM_SCREEN, arrayListOf())
        "/ask/chat/" -> BeaconActivity.open(context, BeaconScreens.CHAT, arrayListOf())
        "/answers/" -> BeaconActivity.open(context, BeaconScreens.PREVIOUS_MESSAGES, arrayListOf())
        else -> Log.w(TAG, "[navigate] Path '${path ?: "null"}' not supported")
      }
    }

    Function("suggestArticles") { articleIds: List<String>? ->
      if (beacon == null) {
        Log.w(TAG, "[suggestArticles] Not initialized - did you forget to call 'init'?")
        return@Function
      }

      if (articleIds.isNullOrEmpty()) {
        Log.w(TAG, "[suggestArticles] Missing or empty articleIds")
        return@Function
      }

      val suggestedArticles = articleIds.take(5).map {
        SuggestedArticle.SuggestedArticleWithId(it)
      }

      Beacon.setOverrideSuggestedArticlesOrLinks(suggestedArticles)
    }

    Function("resetSuggestions") {
      if (beacon == null) {
        Log.w(TAG, "[resetSuggestions] Not initialized - did you forget to call 'init'?")
        return@Function null
      }
      Beacon.setOverrideSuggestedArticlesOrLinks(emptyList())
    }

  }
}
