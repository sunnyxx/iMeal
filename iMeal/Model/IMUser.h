//
//  IMUser.h
//  iMeal
//
//  Created by 萨萨萨 on 15/2/27.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@class IMTeam;

@interface IMUser : AVUser <AVSubclassing>

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) AVRelation *money;//IMMoney
@property (nonatomic, strong) AVRelation *rechargeBills;
@property (nonatomic, strong) AVRelation *costBills;

//currentUser;
//logOut;

@end

@interface IMUser (Server)

+ (BOOL)isSigned;
+ (void)autoSingin:(void(^)(BOOL complelte, IMUser *user, NSError *error))complete;
+ (void)signin:(NSString *)nickName complete:(void(^)(BOOL complelte, IMUser *user, NSError *error))complete;

+ (void)teams:(void(^)(BOOL complete, NSArray *teams, NSError *error))complete;

@end
