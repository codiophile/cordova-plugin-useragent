#import "GSUserAgent.h"

#import <Cordova/CDVViewController.h>
#import "GSUserAgentProtocol.h"
#import <Cordova/CDVPlugin.h>

static NSString *const kUserAgent = @"useragent";

@implementation GSUserAgent {
    BOOL agentProtocolRegistered;
}

- (void)pluginInitialize {
    agentProtocolRegistered = false;
    if ([self.viewController isKindOfClass:[CDVViewController class]]) {
        CDVViewController *viewController = (CDVViewController *)self.viewController;
        [self.webViewEngine evaluateJavaScript:@"navigator.userAgent" completionHandler:^(NSString* userAgent, NSError* error) {
            if (viewController.settings[kUserAgent]) {
                userAgent = viewController.settings[kUserAgent];
            }
            agentProtocolRegistered = true;
            [GSUserAgentProtocol setUserAgent:userAgent];
            [NSURLProtocol registerClass:GSUserAgentProtocol.class];
        }];
    }
}

- (void)setUserAgent:(CDVInvokedUrlCommand*)command
{
    NSString *userAgent = [command argumentAtIndex:0];
    NSString *callbackId = command.callbackId;
    if (agentProtocolRegistered) {
        [GSUserAgentProtocol setUserAgent:userAgent];
        CDVPluginResult* pluginResult =[CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    } else {
        CDVPluginResult* pluginResult =[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    }
}

@end