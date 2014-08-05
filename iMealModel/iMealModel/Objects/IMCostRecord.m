//
//  IMCostRecord.m
//  iMealModel
//
//  Created by sunnyxx on 14-7-30.
//
//

#import "IMCostRecord.h"

@implementation IMCostRecord

@dynamic date, member, restaurant, costMoney, fromMoney;

+ (NSString *)parseClassName
{
    return @"CostRecord";
}

@end
