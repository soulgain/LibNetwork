//
//  NetworkServerManager.h
//  LibNetwork
//
//  Created by apple on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkServerManager : NSObject

@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, copy) NSString *commonPara;

+ (NetworkServerManager *)getInstace;

@end
