//
//  IMAudioPlayer.h
//  iMeal
//
//  Created by sunnyxx on 14-8-9.
//
//

#import <Foundation/Foundation.h>

@interface IMAudioPlayer : NSObject

+ (void)playSoundNamed:(NSString *)name;

@end

@interface IMAudioPlayer (IMSoundEffects)

+ (void)playLoginSound;
+ (void)playMoneyChargedSound;

@end