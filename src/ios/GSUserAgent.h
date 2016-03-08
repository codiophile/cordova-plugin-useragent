#import <Cordova/CDV.h>

@interface GSUserAgent : CDVPlugin
{}

- (void)setUserAgent:(CDVInvokedUrlCommand*)command;

@end