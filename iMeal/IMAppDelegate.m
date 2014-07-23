//
//  IMAppDelegate.m
//  iMeal
//
//  Created by sunnyxx on 14-7-24.
//
//

#import "IMAppDelegate.h"
#import "IMServer.h"

@implementation IMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup server
    [IMServer setup];
    
    return YES;
}

@end
