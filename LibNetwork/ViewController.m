//
//  ViewController.m
//  LibNetwork
//
//  Created by apple on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Network.h"
#import "NetworkServerManager.h"
#import "NetworkConnectionManager.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // example
    // http://ws.qunar.com/all_lp.jcp?goDate=%s&from=%s&to=%s&output=json&count=90
    NetworkServerManager *serverManager = [NetworkServerManager getInstace];
    serverManager.serverAddress = @"ws.qunar.com";
    
    NSURLRequest *request = [Network requestWithUri:@"/all_lp.jcp" params:@"goDate=2013-08-20&from=上海&to=北京&output=json&count=5" httpMethod:HTTP_GET];
    Network *net = [Network send:request withBlock:^(NSData *data, NSError *error) {
        if (error) {
            // handle error
            NSLog(@"%@", error);
        } else {
            NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", ret);
        }
    } andGroupName:nil];
    NSLog(@"%@", net);
    
    NetworkConnectionManager *a = [[NetworkConnectionManager alloc] init];
    [a cancelAll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
