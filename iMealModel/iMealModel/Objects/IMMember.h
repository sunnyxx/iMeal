//
//  MFTeamMember.h
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//  Copyright (c) 2014年 sunnyxx. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMMember : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *nickname;

@end
