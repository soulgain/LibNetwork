//
//  NetworkServerManager.m
//  LibNetwork
//
//  Created by apple on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NetworkServerManager.h"

@implementation NetworkServerManager

+ (NetworkServerManager *)getInstace
{
    static NetworkServerManager *singleton;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[NetworkServerManager alloc] init];
    });
    
    return singleton;
}

@end
