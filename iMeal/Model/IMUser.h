//
//  IMUser.h
//  iMeal
//
//  Created by 萨萨萨 on 15/2/27.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMUser : AVUser <AVSubclassing>

@property (nonatomic, copy) NSString *nickName;

@end

@interface IMUser (Server)

+ (BOOL)isSigned;
+ (void)autoSingin:(void(^)(BOOL complelte, IMUser *user, NSError *error))complete;
+ (void)signin:(NSString *)nickName complete:(void(^)(BOOL complelte, IMUser *user, NSError *error))complete;

@end
