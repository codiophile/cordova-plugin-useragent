# cordova-plugin-useragent
A plugin that reads the user agent value from config.xml and sets that as user agent for all requests made by the web view.

Also you can change user agent from js:

```
cordova.exec(function() {/* success */}, function (err) {/* fail */}, "UserAgent", "setUserAgent", ['New User Agent Value']);
```