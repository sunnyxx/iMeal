//
//  AppDelegate.m
//  iMeal
//
//  Created by sunnyxx on 15/2/9.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import "AppDelegate.h"
#import "IMSetup.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [IMSetup setup];
    
    return YES;
}

@end
