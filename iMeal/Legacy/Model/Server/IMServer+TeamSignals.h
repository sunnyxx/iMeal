//
//  IMServer+Team.h
//  iMealModel
//
//  Created by sunnyxx on 14-8-6.
//
//

#import "IMServer.h"

/// Team concerned request signals
@interface IMServer (TeamSignals)

/// Signal for fetch latest data of current team
/// `+ [IMTeam currentTeam]` is updated
+ (RACSignal *)refreshCurrentTeamSignal;

/// Signals in `Guide`
/// User create or enter a team with `sign`
+ (RACSignal *)createTeamSignalWithSign:(NSString *)sign;
+ (RACSignal *)enterTeamSignalWithSign:(NSString *)sign;

/// Signal for add member into current team
+ (RACSignal *)addMemberSignalWithNickname:(NSString *)nickname;

/// Signal for remove member out of current team
+ (RACSignal *)removeMemberSignal:(IMMember *)member;

/// Signal for get all members in current team
/// Note: load from cache if exist
+ (RACSignal *)allTeamMembersSignal;

@end
