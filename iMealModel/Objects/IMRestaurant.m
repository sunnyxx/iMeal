//
//  IMRestaurant.m
//  iMealModel
//
//  Created by sunnyxx on 14-7-30.
//
//

#import "IMRestaurant.h"

@implementation IMRestaurant

@dynamic name, location;

#pragma mark - AVSubclassing

+ (NSString *)parseClassName
{
    return @"Restaurant";
}

@end
