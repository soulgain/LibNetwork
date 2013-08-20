//
//  Network.m
//  LibNetwork
//
//  Created by falcon on 13-6-7.
//  Copyright (c) 2013年 falcon. All rights reserved.
//

#import "Network.h"
#import "NetworkServerManager.h"

static unsigned int connections = 0;

@interface Network() <NSURLConnectionDataDelegate>

@property (nonatomic, retain) NSURLConnection *connect;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, copy) void (^handler)(NSData* data, NSError* error);

@end


@implementation Network

#pragma mark - logic

+ (NSURLRequest *)requestWithUri:(NSString*)uri params:(NSString*)params httpMethod:(NSString*)method
{
    NetworkServerManager *serverManager = [NetworkServerManager getInstace];
    
    if ([serverManager.commonPara length] > 0) {
        params = [params stringByAppendingFormat:@"&%@", serverManager.commonPara];
    }
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod = method;
    request.timeoutInterval = 30;
    request.HTTPShouldHandleCookies = YES;
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    params = [params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if([method isEqualToString:@"GET"])
    {
        NSString *strURL = [NSString stringWithFormat:@"http://%@%@?%@", serverManager.serverAddress, uri, params];
        request.URL = [NSURL URLWithString:strURL];
        NSLog(@"%@", strURL);
    }
    else
    {
        request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@", serverManager.serverAddress, uri]];
        request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    }
    return [request autorelease];
}

+ (Network *)send:(NSURLRequest *)request withBlock:(void (^)(NSData* data, NSError* error))handler
{
    Network *net = [[Network alloc] init];
    [net start:request withBlock:handler];
    
    return [net autorelease];
}

- (void)start:(NSURLRequest *)request withBlock:(void (^)(NSData* data, NSError* error))handler
{
    [self stop];
    
    self.handler = handler;
    _data = [[NSMutableData alloc] init];
    _connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    connections++;
    _active = YES;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)stop
{
    if (_connect) {
        [_connect cancel];
        self.connect = nil;
        
        if(_active)
            connections--;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:connections > 0];
    }

    self.data = nil;
    self.handler = nil;
}

- (void)dealloc
{
    self.connect = nil;
    self.data = nil;
    self.handler = nil;
    
    [super dealloc];
}


#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _active = NO;
    connections--;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:connections > 0];
    
    _handler(nil, error);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _active = NO;
    connections--;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:connections > 0];
    
    _handler(_data, nil);
}

@end
