package com.gamesys.plugin;

import org.apache.cordova.*;

import android.webkit.WebSettings;
import android.webkit.WebView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class UserAgent extends CordovaPlugin {

    private static final String kUserAgent = "useragent";
    private WebSettings settings;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        // Load cordova settings
        String userAgent = cordova.getActivity().getIntent().getStringExtra(kUserAgent);

        // Build user agent
        settings = ((WebView) webView.getEngine().getView()).getSettings();
        if (userAgent == null) {
            userAgent = settings.getUserAgentString();
        }

        // Set user agent
        settings.setUserAgentString(userAgent);
    }

    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (action.equals("setUserAgent")) {
            final String userAgent = args.getString(0);
            settings.setUserAgentString(userAgent);
            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, new JSONArray()));
        } else {
            return false;
        }
        return true;
    }
}
