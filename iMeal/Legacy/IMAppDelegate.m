//
//  IMAppDelegate.m
//  iMeal
//
//  Created by sunnyxx on 14-7-24.
//
//

#import "IMAppDelegate.h"
#import "IMServer.h"
#import "IMRouter.h"

@implementation IMAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup server
    [IMServer setup];
    
    // Setup root vc by login state
    [[IMRouter globalRouter] setupRootViewController];
    
    return YES;
}

@end
