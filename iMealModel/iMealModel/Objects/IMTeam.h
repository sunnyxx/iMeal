//
//  MFTeam.h
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//  Copyright (c) 2014年 sunnyxx. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMTeam : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) AVRelation *members;

@end
