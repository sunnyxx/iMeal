//
//  IMBills.h
//  iMeal
//
//  Created by 萨萨萨 on 15/3/2.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@class IMUser;

@interface IMBills : AVObject <AVSubclassing>

@property (nonatomic, strong) AVRelation *users;
@property (nonatomic, strong) IMUser *paidUser;


@end
