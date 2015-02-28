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

@implementation IMUser

@end

@implementation IMUser (Server)

+ (BOOL)isSigned {
    return [SSKeychain accountsForService:@"iMeal"].count > 0;
}

+ (void)autoSingin:(void (^)(BOOL, IMUser *, NSError *))complete {
    NSArray *keychians = [SSKeychain accountsForService:@"iMeal"];
    SSKeychainQuery *query = [keychians lastObject];
    
    [IMUser logInWithUsernameInBackground:query.account
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
                                            [SSKeychain setPassword:nil
                                                         forService:@"iMeal"
                                                            account:nickName
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

@end
