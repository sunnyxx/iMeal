//
//  IMMoney.m
//  iMeal
//
//  Created by 萨萨萨 on 15/3/3.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import "IMMoney.h"

@implementation IMMoney

@dynamic teamId, balance;

+  (NSString *)parseClassName {
    return @"IMMoney";
}

- (BOOL)isEqual:(id)object {
    
    if (![object isKindOfClass:[IMMoney class]]) {
        return NO;
    }
    
    return [self.teamId isEqualToString:[(IMMoney *)object teamId]];
}

- (NSUInteger)hash {
    NSString *hashString = [NSString stringWithFormat:@"%@::%f",self.teamId,self.balance];
    return [hashString hash];
}

@end
