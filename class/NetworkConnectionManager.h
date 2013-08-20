//
//  NetworkConnectionManager.h
//  LibNetwork
//
//  Created by falcon on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Network;

@interface NetworkConnectionManager : NSObject

+ (NetworkConnectionManager *)getInstance;

- (void)cancelConnectionWithGroupName:(NSString *)groupName;
- (void)cancelAll;
- (void)addConnection:(Network *)connection withGroupName:(NSString *)groupName;
- (void)removeConnection:(Network *)connection;

@end
