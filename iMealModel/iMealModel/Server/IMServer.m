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
    // This method must be called before [AVOSCloud setApplicationId:clientKey:]
    [IMMember registerSubclass];
    [IMTeam registerSubclass];
    [IMRestaurant registerSubclass];
    [IMChargeRecord registerSubclass];
    [IMCostRecord registerSubclass];
    
    [AVOSCloud setApplicationId:@"lwqrtun88ejwd9omplkeivhtiu9vv3zzo60ngt64qygtkdvp"
                      clientKey:@"w2xg21mruyuvr44yjmimg4o952rptlb0c40qwur33s89w2el"];
}

+ (RACSignal *)createTeamSignalWithTeamName:(NSString *)name
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // Get last biggest team number
        AVQuery *query = [IMTeam query];
        [query orderByDescending:@"number"];
        [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
            IMTeam *lastTeam = (IMTeam *)object;
            
            // Team number +1
            NSString *number = lastTeam.number ?: @"0000000";
            NSString *newTeamNumber = [NSString stringWithFormat:@"07%d", [number integerValue] + 1];
            
            IMTeam *newTeam = [IMTeam object];
            newTeam.name = name;
            newTeam.number = newTeamNumber;
            [newTeam saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    [subscriber sendError:error];
                }
                
                // Store local
                [newTeam storeAsCurrentTeam];
                
                [subscriber sendCompleted];
            }];

        }];
        return nil;
    }];

    
    return [RACSignal return:@YES];
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
            }
            IMTeam *team = [IMTeam currentTeam];
            [team.members addObject:member];
            [team saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    [subscriber sendError:error];
                }
                [subscriber sendCompleted];

            }];
        }];
    
        return nil;
    }];
}

+ (RACSignal *)allMembersSignalInCurrentTeam
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        IMTeam *team = [IMTeam currentTeam];
        AVQuery *query = [team.members query];
        query.cachePolicy = kAVCachePolicyCacheThenNetwork;
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

+ (RACSignal *)chargeSignalWithCharger:(IMMember *)charger receiver:(IMMember *)receiver money:(CGFloat)money
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // Update team's receiver
        IMTeam *currentTeam = [IMTeam currentTeam];
        currentTeam.receiver = receiver;
        [currentTeam saveEventually]; // No need to care result
        
        // Record
        IMChargeRecord *record = [IMChargeRecord new];
        record.date = [NSDate new];
        record.team = currentTeam;
        record.charger = charger;
        record.receiver = receiver;
        record.money = money;
        [record saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (error) {
                [subscriber sendError:error];
            }
            
            // Exchange money
            charger.money += money;
            receiver.money -= money;
            
            // Use dispatch group to sync async requests
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            [charger saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    [subscriber sendError:error];
                }
                dispatch_group_leave(group);
            }];
            dispatch_group_enter(group);
            [receiver saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    [subscriber sendError:error];
                }
                dispatch_group_leave(group);
            }];
            
            // All done
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                [subscriber sendCompleted];
            });
        }];
        
        return nil;
    }];
}

@end
