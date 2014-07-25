//
//  IMServer.h
//  iMealModel
//
//  Created by sunnyxx on 14-7-24.
//
//

@interface IMServer : NSObject

+ (void)setup;

@end

@class IMTeam, IMAdministrator;

@interface IMServer (IMApiRequest)

+ (RACSignal *)createTeam:(IMTeam *)team byAdministrator:(IMAdministrator *)admin;

@end
