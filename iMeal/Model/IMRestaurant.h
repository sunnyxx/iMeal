//
//  IMRestaurant.h
//  iMeal
//
//  Created by 萨萨萨 on 15/3/2.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMRestaurant : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *name;
//次数
@property (nonatomic, assign) NSUInteger count;
//人均
@property (nonatomic, assign) CGFloat avgprice;
//评价
@property (nonatomic, assign) int star;

@end
