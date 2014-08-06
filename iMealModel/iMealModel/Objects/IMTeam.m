//
//  MFTeam.m
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//
//

#import "IMTeam.h"
#import "IMMember.h"

@implementation IMTeam

@dynamic name, sign, members, restaurants, receiver;

#pragma mark - AVSubclassing

+ (NSString *)parseClassName
{
    return @"Team";
}

#pragma mark - Current team

NSString *const kIMCurrentTeamIdKey = @"IMCurrentTeamId";
static IMTeam *_currentTeam = nil;

+ (NSString *)cachedTeamId
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kIMCurrentTeamIdKey];
}

+ (void)cacheTeamId:(NSString *)teamId
{
    [[NSUserDefaults standardUserDefaults] setObject:teamId forKey:kIMCurrentTeamIdKey];
}

+ (IMTeam *)currentTeam
{
    return _currentTeam;
}

- (void)storeAsCurrentTeam
{
    _currentTeam = self;
}

@end
