//
//  JLAppDelegate.m
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

#import "JLAppDelegate.h"
#import "JLNetworkRequest.h"

@implementation JLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[JLNetworkRequest sharedNetworkRequest] initialize];
    //remove param for pageNum
    [[JLNetworkRequest sharedNetworkRequest] fetchRequest];
    
    return YES;
}

@end
