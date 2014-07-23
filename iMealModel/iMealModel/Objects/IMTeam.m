//
//  MFTeam.m
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//  Copyright (c) 2014年 sunnyxx. All rights reserved.
//

#import "IMTeam.h"

@implementation IMTeam
@dynamic name, members;

#pragma mark - AVSubclassing

+ (NSString *)parseClassName
{
    return @"Team";
}

@end
