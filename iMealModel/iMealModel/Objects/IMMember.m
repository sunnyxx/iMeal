//
//  MFTeamMember.m
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//  
//

#import "IMMember.h"

@implementation IMMember

@dynamic nickname, money, keptMoney;

#pragma mark - AVSubclassing

+ (NSString *)parseClassName
{
    return @"Member";
}

@end
