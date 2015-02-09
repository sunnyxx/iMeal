//
//  IMFormatDisplay.m
//  iMeal
//
//  Created by sunnyxx on 14-8-9.
//
//

#import "IMFormatDisplay.h"

@implementation NSNumber (IMFormatDisplay)

- (NSString *)im_money
{
    return IMMoneyDisplay(self.floatValue);
}

@end

@implementation RACStream (IMFormatDisplay)

- (instancetype)im_moneyMap
{
    return [[self map:^id(NSNumber *value) {
        return [value im_money];
    }] setNameWithFormat:@"RACStream (IMUtilsSignals) money map"];
}

@end