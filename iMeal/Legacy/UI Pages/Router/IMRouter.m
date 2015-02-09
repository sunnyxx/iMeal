//
//  IMRouter.m
//  iMeal
//
//  Created by sunnyxx on 14-8-8.
//
//

#import "IMRouter.h"
#import "IMAppDelegate.h"
#import "IMTeam.h"
#import "IMGuideVC.h"
#import "IMAudioPlayer.h"

@implementation IMRouter

+ (instancetype)globalRouter
{
    static IMRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [IMRouter new];
    });
    return instance;
}

- (void)setupRootViewController
{
    if ([IMTeam currentTeam])
    {
        self.mainWindow.rootViewController = [self createMainViewController];
    }
    else
    {
        self.mainWindow.rootViewController = [self createGuideViewController];
    }
    [IMAudioPlayer playLoginSound];
}

- (void)login
{
    self.mainWindow.rootViewController = [self createMainViewController];
    [IMAudioPlayer playLoginSound];
}

- (void)logout
{
    self.mainWindow.rootViewController = [self createGuideViewController];
}

#pragma mark - Helpers

- (UIWindow *)mainWindow
{
    IMAppDelegate *app = [UIApplication sharedApplication].delegate;
    return app.window;
}

- (UIViewController *)createGuideViewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Guide" bundle:nil];
    return [sb instantiateInitialViewController];
}

- (UIViewController *)createMainViewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [sb instantiateInitialViewController];
}

@end
