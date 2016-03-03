#import "GSUserAgentProtocol.h"

@interface GSUserAgentProtocol()

@property (nonatomic, strong) NSMutableData *mutableData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSURLConnection *connection;

@end

static NSString *_userAgent = nil;

@implementation GSUserAgentProtocol

+ (void)setUserAgent:(NSString *)userAgent {
    _userAgent = userAgent;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return _userAgent && ![[request valueForHTTPHeaderField:@"User-Agent"] isEqualToString:_userAgent];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    [mutableRequest setValue:_userAgent forHTTPHeaderField:@"User-Agent"];
    self.connection = [NSURLConnection connectionWithRequest:mutableRequest delegate:self];
}

- (void) stopLoading {
    [self.connection cancel];
    self.connection = nil;
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.response = response;
    self.mutableData = [[NSMutableData alloc] init];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.mutableData appendData:data];
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

@end
