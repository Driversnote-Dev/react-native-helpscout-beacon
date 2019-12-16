package com.driversnote;

import android.text.TextUtils;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import java.util.*;
import com.helpscout.beacon.Beacon;
import com.helpscout.beacon.ui.BeaconActivity;
import com.helpscout.beacon.model.BeaconScreens;
import com.helpscout.beacon.model.SuggestedArticle;

public class HelpscoutBeaconModule extends ReactContextBaseJavaModule {
    private final ReactApplicationContext reactContext;

    public HelpscoutBeaconModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "HelpscoutBeacon";
    }

    @ReactMethod
    public void login(String email, String name, String userID) {
        if (TextUtils.isEmpty(email) || TextUtils.isEmpty(name)) {
            return;
        }
        Beacon.login(email, name);
        Beacon.addAttributeWithKey("userId", userID);
    }

    @ReactMethod
    public void open(String signature) {
        BeaconActivity.openInSecureMode(this.reactContext, signature);
    }

    @ReactMethod
    public void loginAndOpen(String email, String name, String userID, String signature) {
        login(email, name, userID);
        open(signature);
    }

    @ReactMethod
    public void logout() {
        Beacon.logout();
    }

    @ReactMethod
    public void openArticle(String articleID, String signature) {
        BeaconActivity.openInSecureMode(this.reactContext, signature, BeaconScreens.ARTICLE_SCREEN, new ArrayList<>(Arrays.asList(articleID)));
    }

    @ReactMethod
    public void suggestArticles(String[] articleIDList) {
        // There is a limit of 5 article ids. If the list is larger than 5 the additional articles will be ignored.
        List<SuggestedArticle> suggestedArticles = new ArrayList(Arrays.asList(articleIDList));
        Beacon.setOverrideSuggestedArticlesOrLinks(suggestedArticles);
    }

    @ReactMethod
    public void resetSuggestions() {
        Beacon.setOverrideSuggestedArticlesOrLinks(new ArrayList());
    }
}
