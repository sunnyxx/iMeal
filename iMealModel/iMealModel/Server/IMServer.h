//
//  IMServer.h
//  iMealModel
//
//  Created by sunnyxx on 14-7-24.
//
//

#import "IMModelObjects.h"

@interface IMServer : NSObject

+ (void)setup;

@end

@interface IMServer (IMApiRequest)

+ (RACSignal *)createTeamSignalWithTeamName:(NSString *)name;

/// Signal for add member into current team
+ (RACSignal *)addMemberSignalWithNickname:(NSString *)nickname;

/// Signal for get all members in current team
/// Note: load from cache if exist
+ (RACSignal *)allMembersSignalInCurrentTeam;

/// Signal for charge money in.
/// This will:
/// 1. Build a `IMChargeRecord` object to record it
/// 2. charger.money += money
/// 3. receiver.money -= money
+ (RACSignal *)chargeSignalWithCharger:(IMMember *)charger
                              receiver:(IMMember *)receiver
                                 money:(CGFloat)money;

@end
