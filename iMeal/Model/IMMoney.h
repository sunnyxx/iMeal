//
//  IMMoney.h
//  iMeal
//
//  Created by 萨萨萨 on 15/3/3.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMMoney : AVObject <AVSubclassing>

@property(nonatomic, copy) NSString *teamId;
@property(nonatomic, assign) CGFloat balance;

@end
