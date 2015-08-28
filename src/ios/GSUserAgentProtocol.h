#import <Foundation/Foundation.h>

@interface GSUserAgentProtocol : NSURLProtocol<NSURLConnectionDelegate>

+ (void)setUserAgent:(NSString *)userAgent;

@end
