//
//  IMServer.m
//  iMealModel
//
//  Created by sunnyxx on 14-7-24.
//
//

#import "IMServer.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation IMServer

+ (void)setup
{
    //This method must be called before [AVOSCloud setApplicationId:clientKey:]
    [IMMember registerSubclass];
    
    [AVOSCloud setApplicationId:@"lwqrtun88ejwd9omplkeivhtiu9vv3zzo60ngt64qygtkdvp"
                      clientKey:@"w2xg21mruyuvr44yjmimg4o952rptlb0c40qwur33s89w2el"];
}

+ (RACSignal *)createTeam:(IMTeam *)team byAdministrator:(IMAdministrator *)admin
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [team saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            }
            else {
                [subscriber sendCompleted];
            }
        }];
        
        return nil;
    }];
}

+ (RACSignal *)addMember:(IMMember *)member intoTeam:(IMTeam *)team
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [team.membersRelation addObject:team];
        [team saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            }
            else {
                [subscriber sendCompleted];
            }
        }];
        
        return nil;
    }];
}

+ (RACSignal *)addMemberIntoCurrentTeamWithNickname:(NSString *)nickname
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        IMMember *member = [IMMember object];
        member.nickname = nickname;
        [member save];
        
        IMTeam *team = [IMTeam currentTeam];
        [team.membersRelation addObject:member];
        [team saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
        }];
        [IMServer addMember:member intoTeam:[IMTeam currentTeam]];
        
        [team.membersRelation addObject:team];
        [team saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            }
            else {
                [subscriber sendCompleted];
            }
        }];
        
        return nil;
    }];
}

@end
