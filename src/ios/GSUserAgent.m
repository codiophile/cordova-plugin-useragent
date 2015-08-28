#import "GSUserAgent.h"

#import <Cordova/CDVViewController.h>
#import "GSUserAgentProtocol.h"

static NSString *const kUserAgent = @"useragent";
static NSString *const kUserAgentPrefix = @"useragentprefix";
static NSString *const kUserAgentPostfix = @"useragentpostfix";

@implementation GSUserAgent

- (void)pluginInitialize {
    if ([self.viewController isKindOfClass:[CDVViewController class]]) {
        CDVViewController *viewController = (CDVViewController *)self.viewController;
        NSString *userAgent = nil;
        if (viewController.settings[kUserAgent]) {
            userAgent = viewController.settings[kUserAgent];
        } else {
            userAgent = [self.webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        }
        if (viewController.settings[kUserAgentPrefix]) {
            userAgent = [NSString stringWithFormat:@"%@ %@", viewController.settings[kUserAgentPrefix], userAgent];
        }
        if (viewController.settings[kUserAgentPostfix]) {
            userAgent = [NSString stringWithFormat:@"%@ %@", userAgent, viewController.settings[kUserAgentPostfix]];
        }
        [GSUserAgentProtocol setUserAgent:userAgent];
        [NSURLProtocol registerClass:GSUserAgentProtocol.class];
    }
}

@end