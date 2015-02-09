//
//  IMFormatDisplay.h
//  iMeal
//
//  Created by sunnyxx on 14-8-9.
//
//

#import <Foundation/Foundation.h>

static inline NSString *IMMoneyDisplay(CGFloat money)
{
    if (money - (NSInteger)money > 0) {
        return [NSString stringWithFormat:@"%.1f", money];
    }
    return [NSString stringWithFormat:@"%.0f", money];
}

@interface NSNumber (IMFormatDisplay)

- (NSString *)im_money;

@end

@interface RACStream (IMFormatDisplay)

/// Money(float 123.5) -> (NSString *)`￥123.5`
- (instancetype)im_moneyMap;

@end