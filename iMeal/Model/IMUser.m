//
//  IMUser.m
//  iMeal
//
//  Created by 萨萨萨 on 15/2/27.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import "IMUser.h"
#import <SSKeychain/SSKeychain.h>
#import "IMMarco.h"
#import "IMTeam.h"

@implementation IMUser

@dynamic nickName, money, rechargeBills, costBills;

+ (NSString *)parseClassName {
    return @"_User";
}

@end

@implementation IMUser (Server)

+ (BOOL)isSigned {
    return [SSKeychain accountsForService:@"iMeal"].count > 0;
}

+ (void)autoSingin:(void (^)(BOOL, IMUser *, NSError *))complete {
    NSArray *keychians = [SSKeychain accountsForService:@"iMeal"];
    SSKeychainQuery *keychain = [keychians lastObject];
    
    [IMUser logInWithUsernameInBackground:keychain.password
                                 password:nil
                                    block:^(AVUser *user, NSError *error) {
                                        if (error) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (complete) {
                                                    complete(NO, nil, error);
                                                }
                                            });
                                        }
                                        else {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (complete) {
                                                    complete(YES, (IMUser *)user, nil);
                                                }
                                            });
                                        }
                                    }];
}

+ (void)signin:(NSString *)nickName complete:(void (^)(BOOL, IMUser *, NSError *))complete {
    [IMUser logInWithUsernameInBackground:nickName
                                 password:nil
                                    block:^(AVUser *user, NSError *error) {
                                        if (error) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (complete) {
                                                    complete(NO, nil, error);
                                                }
                                            });
                                        }
                                        else {
                                            //store nickName in keychain
                                            [SSKeychain setPassword:nickName
                                                         forService:@"iMeal"
                                                            account:user.objectId
                                                              error:&error];
                                            if (error) {
                                                DebugLog(@"Store nickName >>%@<< in keychain fail:%@", nickName,error.localizedDescription);
                                            }
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (complete) {
                                                    complete(YES, (IMUser *)user, nil);
                                                }
                                            });
                                        }
                                    }];
}

+ (void)teams:(void (^)(BOOL, NSArray *, NSError *))complete {
    AVQuery *query = [AVRelation reverseQuery:NSStringFromClass([IMTeam class])
                                  relationKey:@"users"
                                  childObject:[IMUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(NO, nil, error);
                }
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(YES, objects, nil);
                }
            });
        }
    }];
}

@end
