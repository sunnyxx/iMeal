//
//  MFTeam.h
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//  
//

#import <AVOSCloud/AVOSCloud.h>

@class IMMember;

@interface IMTeam : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *name;

/// Team sign, secret code
@property (nonatomic, copy) NSString *sign;

@property (nonatomic, strong) AVRelation *members;
@property (nonatomic, strong) AVRelation *restaurants;

/// Last member that received money from others
@property (nonatomic, strong) IMMember *keeper;

@end

@interface IMTeam (IMCurrentTeam)

+ (IMTeam *)currentTeam;

//+ (NSString *)cachedTeamId;
//+ (void)cacheTeamId:(NSString *)teamId;

- (void)storeAsCurrentTeam;
- (void)logout;
@end
