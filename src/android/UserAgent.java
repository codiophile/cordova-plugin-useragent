package com.gamesys.plugin;

import org.apache.cordova.*;

import android.webkit.WebSettings;
import android.webkit.WebView;

public class UserAgent extends CordovaPlugin {
    private static final String kUserAgent = "useragent";
    private static final String kUserAgentPrefix = "useragentprefix";
    private static final String kUserAgentPostfix = "useragentpostfix";

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        // Load cordova settings
        String userAgent = cordova.getActivity().getIntent().getStringExtra(kUserAgent);
        String userAgentPrefix = cordova.getActivity().getIntent().getStringExtra(kUserAgentPrefix);
        String userAgentPostfix = cordova.getActivity().getIntent().getStringExtra(kUserAgentPostfix);

        // Build user agent
        WebSettings settings = ((WebView) webView.getEngine().getView()).getSettings();
        if (userAgent == null) {
            userAgent = settings.getUserAgentString();
        }
        if (userAgentPrefix != null) {
            userAgent = userAgentPrefix + " " + userAgent;
        }
        if (userAgentPostfix != null) {
            userAgent = userAgent + " " + userAgentPostfix;
        }

        // Set user agent
        settings.setUserAgentString(userAgent);
    }
}
