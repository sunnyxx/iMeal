//
//  IMAudioPlayer.m
//  iMeal
//
//  Created by sunnyxx on 14-8-9.
//
//

#import "IMAudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface IMAudioPlayer ()

@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation IMAudioPlayer

+ (IMAudioPlayer *)innerInstance
{
    static IMAudioPlayer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [IMAudioPlayer new];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

+ (void)playSoundNamed:(NSString *)name
{
#if !TARGET_IPHONE_SIMULATOR
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
    self.innerInstance.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    [self.innerInstance.player play];
#endif
}

@end

@implementation IMAudioPlayer (IMSoundEffects)

+ (void)playLoginSound
{
   [self playSoundNamed:@"loading_screen_jingle.caf"];
}

+ (void)playMoneyChargedSound
{
    [self playSoundNamed:@"money2.caf"];
}

@end