//
//  IMTeam.h
//  iMeal
//
//  Created by 萨萨萨 on 15/3/1.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMTeam : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ownerId;
@property (nonatomic, strong) AVRelation *users;//IMUsers
@property (nonatomic, strong) AVRelation *restaurants;//IMRestaurant
@property (nonatomic, strong) AVRelation *bills;//IMBills



@end

@interface IMTeam (Server)

+ (void)createTeam:(NSString *)teamName complete:(void(^)(BOOL complete, IMTeam *team, NSError *error))complete;
+ (void)joinTeam:(NSString *)teamId complete:(void(^)(BOOL complete, NSError *error))complete;
+ (void)quitTeam:(void(^)(BOOL complete, NSError *error))complete;

@end
