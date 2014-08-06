//
//  IMServer+Team.m
//  iMealModel
//
//  Created by sunnyxx on 14-8-6.
//
//

#import "IMServer+TeamSignals.h"

@implementation IMServer (TeamSignals)

+ (RACSignal *)refreshCurrentTeamSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // Load cached team id
        NSString *teamId = [IMTeam cachedTeamId];
        
        if (teamId) {
            AVQuery *query = [IMTeam query];
            query.cachePolicy = kAVCachePolicyIgnoreCache;
            [query includeKey:@"receiver"];
            [query getObjectInBackgroundWithId:teamId block:^(AVObject *object, NSError *error) {
                
                // Save as current team
                // Then we can get it from `+ [IMTeam currentTeam]`
                [(IMTeam *)object storeAsCurrentTeam];
                
                [subscriber sendNext:object];
                [subscriber sendCompleted];
            }];
        }
        
        // Team id not exists;
        else {
            [subscriber sendError:nil];
        }
        
        return nil;
    }];
    
}

+ (RACSignal *)createTeamSignalWithSign:(NSString *)sign
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // Check if this team code exists
        AVQuery *query = [IMTeam query];
        [query whereKey:@"sign" equalTo:sign];
        [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
            if (number > 0) {
                [subscriber sendError:error];
                return;
            }
            
            IMTeam *newTeam = [IMTeam object];
            newTeam.sign = sign;
            [newTeam saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    [subscriber sendError:error];
                    return;
                }
                
                // Store local
                [IMTeam cacheTeamId:newTeam.objectId];
                [newTeam storeAsCurrentTeam];
                
                [subscriber sendCompleted];
            }];
            
        }];
        return nil;
    }];
    
    
    return [RACSignal return:@YES];
}

+ (RACSignal *)enterTeamSignalWithTeamNumber:(NSString *)number
{
    return nil;
}


+ (RACSignal *)addMemberSignalWithNickname:(NSString *)nickname
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        IMMember *member = [IMMember object];
        member.nickname = nickname;
        member.money = 0;
        [member saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [subscriber sendError:error];
                return;
            }
            IMTeam *team = [IMTeam currentTeam];
            [team.members addObject:member];
            [team saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    [subscriber sendError:error];
                    return;
                }
                [subscriber sendNext:member];
                [subscriber sendCompleted];
                
            }];
        }];
        
        return nil;
    }];
}

+ (RACSignal *)removeMemberSignal:(IMMember *)member
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // Delete this object
        AVQuery *query = [IMMember query];
        [query whereKey:@"objectId" equalTo:member.objectId];
        [query deleteAllInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [subscriber sendError:error];
                return;
            }
            
            // Update team members' relation
            IMTeam *team = [IMTeam currentTeam];
            [team.members removeObject:member];
            [team saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    [subscriber sendError:error];
                    return;
                }
                [subscriber sendCompleted];
            }];
        }];
        
        return nil;
    }];
}

+ (RACSignal *)allTeamMembersSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        IMTeam *team = [IMTeam currentTeam];
        AVQuery *query = [team.members query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            }
            [subscriber sendNext:objects];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}


@end
