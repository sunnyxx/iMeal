//
//  IMProgressHUD.m
//  iMeal
//
//  Created by sunnyxx on 14-8-6.
//
//

#import "IMProgressHUD.h"
#import <UIImageView+PlayGIF.h>

@interface IMProgressHUD ()
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIImageView *gifImageView;
@end

@implementation IMProgressHUD

+ (instancetype)defaultInstance
{
    static dispatch_once_t onceToken;
    static IMProgressHUD *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [IMProgressHUD new];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.alertView = [[UIAlertView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        self.gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
        self.gifImageView.gifPath = path;
    }
    return self;
}

#pragma mark - Progresses

+ (void)loading
{
    [self.defaultInstance loading];
}

+ (void)dismiss
{
    [self.defaultInstance loading];
}

#pragma mark - Inner progresses

- (void)loading
{
    // Show
//    self.alertView.title = @"\n\n\n\n\n";
    [self show];
    
    // Gif
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [self.alertView setValue:view forKey:@"accessoryView"];
//    [self.alertView setValue:self.gifImageView forKey:@"_backgroundImageView"];
//    [self.alertView addSubview:self.gifImageView];
//    self.gifImageView.center = self.alertView.center;
//    [self.gifImageView startGIF];
    
}

- (void)dismiss
{
    // Dismiss
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];

    // Gif
    [self.gifImageView stopGIF];
    [self.gifImageView removeFromSuperview];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, 100, 200);
    self.backgroundColor = [UIColor blueColor];
}

@end
