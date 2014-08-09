//
//  IMServer+MoneySignals.m
//  iMealModel
//
//  Created by sunnyxx on 14-8-6.
//
//

#import "IMServer+MoneySignals.h"

@implementation IMServer (MoneySignals)

+ (RACSignal *)chargeSignalWithCharger:(IMMember *)charger keeper:(IMMember *)keeper money:(CGFloat)money
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // Update team's receiver
        IMTeam *currentTeam = [IMTeam currentTeam];
        currentTeam.keeper = keeper;
        [currentTeam saveEventually]; // No need to care result
        
        // Record
        IMChargeRecord *record = [IMChargeRecord new];
        record.date = [NSDate new];
        record.team = currentTeam;
        record.charger = charger;
        record.keeper = keeper;
        record.money = money;
        [record saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (error) {
                [subscriber sendError:error];
            }
            
            // Exchange money
            charger.money += money;
            keeper.keptMoney += money;
            
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
            [keeper saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    // Roll back
                    charger.money -= money;
                    keeper.keptMoney -= money;
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
