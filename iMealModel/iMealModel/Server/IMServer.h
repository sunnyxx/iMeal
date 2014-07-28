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

+ (RACSignal *)createTeam:(IMTeam *)team byAdministrator:(IMAdministrator *)admin;
+ (RACSignal *)addMember:(IMMember *)member intoTeam:(IMTeam *)team;
+ (RACSignal *)addMemberIntoCurrentTeamWithNickname:(NSString *)nickname;
@end
