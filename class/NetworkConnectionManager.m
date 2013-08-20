//
//  NetworkConnectionManager.m
//  LibNetwork
//
//  Created by falcon on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NetworkConnectionManager.h"
#import "Network.h"

@interface NetworkConnectionManager()

@property (nonatomic, retain) NSMutableDictionary *connectionPool;

@end

@implementation NetworkConnectionManager

- (id)init
{
    self = [super init];
    
    if (self) {
        _connectionPool = [NSMutableDictionary dictionary];
    }
    
    return self;
}

+ (NetworkConnectionManager *)getInstance
{
    static NetworkConnectionManager *singleton;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[NetworkConnectionManager alloc] init];
    });
    
    return singleton;
}

- (void)cancelAll
{
    for (NSMutableArray *group in [_connectionPool allValues]) {
        for (Network *connect in group) {
            if ([connect isKindOfClass:[Network class]]) {
                [connect stop];
            }
        }
    }
    [_connectionPool removeAllObjects];
}

- (void)cancelConnectionWithGroupName:(NSString *)groupName
{
    if (_connectionPool[groupName]) {
        NSMutableArray *group = _connectionPool[groupName];
        for (Network *connection in group) {
            [connection stop];
        }
        [_connectionPool removeObjectForKey:groupName];
    }
}

- (void)addConnection:(Network *)connection withGroupName:(NSString *)groupName
{
    if (_connectionPool[groupName]) {
        NSMutableArray *group = _connectionPool[groupName];
        [group addObject:connection];
    } else {
        NSMutableArray *group = [NSMutableArray array];
        [group addObject:connection];
        _connectionPool[groupName] = group;
    }
}

- (void)removeConnection:(Network *)connection
{
    for (NSMutableArray *group in [_connectionPool allValues]) {
        if ([group containsObject:connection]) {
            [group removeObject:connection];
            break;
        }
    }
}

@end
