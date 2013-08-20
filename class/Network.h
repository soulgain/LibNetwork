//
//  Network.h
//  LibNetwork
//
//  Created by falcon on 13-6-7.
//  Copyright (c) 2013年 falcon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTTP_GET @"GET"
#define HTTP_POST @"POST"

#define kNetworkProblemAlertMessage @"网络或服务忙，请稍后再试"

@interface Network : NSObject

@property (nonatomic) BOOL active;
@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, copy) NSString *commonPara;

+ (NSURLRequest *)requestWithUri:(NSString*)uri params:(NSString*)params httpMethod:(NSString*)method;
+ (Network *)send:(NSURLRequest *)request withBlock:(void (^)(NSData* data, NSError* error))handler andGroupName:(NSString *)groupName;
- (void)stop;

@end
