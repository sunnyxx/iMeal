//
//  IMChargeRecord.m
//  iMealModel
//
//  Created by sunnyxx on 14-7-30.
//
//

#import "IMChargeRecord.h"

@implementation IMChargeRecord

@dynamic date, team, charger, receiver, money;

+ (NSString *)parseClassName
{
    return @"ChargeRecord";
}

@end
