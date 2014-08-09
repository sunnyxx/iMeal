//
//  IMRouter.h
//  iMeal
//
//  Created by sunnyxx on 14-8-8.
//
//

#import <Foundation/Foundation.h>

@interface IMRouter : NSObject

+ (instancetype)globalRouter;

- (void)setupRootViewController;
- (void)login;
- (void)logout;

@end
