package com.gamesys.plugin;

import org.apache.cordova.*;

import android.webkit.WebSettings;
import android.webkit.WebView;

public class UserAgent extends CordovaPlugin {
    @Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
	    super.initialize(cordova, webView);
        // TODO: Load cordova settings
        String userAgent = null;
        // TODO: Set user agent
        WebSettings settings = ((WebView) webView.getEngine().getView()).getSettings();
        settings.setUserAgentString();
	}
}
