//
//  IMTeam.m
//  iMeal
//
//  Created by 萨萨萨 on 15/3/1.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import "IMTeam.h"
#import "IMUser.h"
#import "IMMarco.h"

@implementation IMTeam

@dynamic name, ownerId, users, restaurants, bills;

+ (NSString *)parseClassName {
    return @"IMTeam";
}

@end

@implementation IMTeam (Server)

+ (void)createTeam:(NSString *)teamName complete:(void (^)(BOOL, IMTeam *, NSError *))complete {
    IMTeam *team = [IMTeam object];
    team.name = teamName;
    team.ownerId = [IMUser currentUser].objectId;
    
    AVRelation *relation = [team relationforKey:@"users"];
    [relation addObject:[IMUser currentUser]];
    
    [team saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete (YES, team, nil);
                }
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete (NO, nil, error);
                }
            });
        }
    }];
}

+ (void)joinTeam:(NSString *)teamId complete:(void (^)(BOOL, NSError *))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        IMTeam *team = [IMTeam objectWithoutDataWithObjectId:teamId];
        
        AVRelation *relation = [team relationforKey:@"users"];
        
        if ([[relation query] getObjectWithId:[IMUser currentUser].objectId]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    NSError *error = [NSError errorWithDomain:@"join team error"
                                                         code:1
                                                     userInfo:@{NSLocalizedDescriptionKey: @"你已经加入该组"}];
                    complete(NO, error);
                }
            });
            return;
        }
        
        
        [relation addObject:[IMUser currentUser]];
        
        NSError *error = nil;
        if ([team save:&error]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(YES, nil);
                }
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(NO, error);
                }
            });
        }
    });
}

+ (void)quitTeam:(void (^)(BOOL, NSError *))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AVRelation *relation = [[IMUser currentUser] relationforKey:@"money"];
        
        NSError *error = nil;
        NSArray *money = [[relation query] findObjects:&error];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(NO, error);
                }
            });
        }
        else {
            
        }
        
        
    });
}

@end
