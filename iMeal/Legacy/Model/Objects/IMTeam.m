//
//  IMTeam.m
//  iMealModel
//
//  Created by sunnyxx on 14-7-23.
//
//

#import "IMTeam.h"
#import "IMMember.h"

@interface IMTeam (/*Internal*/)

@end

@implementation IMTeam

@dynamic name, sign, members, restaurants, keeper;

#pragma mark - AVSubclassing

+ (NSString *)parseClassName
{
    return @"Team";
}

@end

@implementation IMTeam (IMCurrentTeam)

NSString *const kIMCurrentTeamIdKey = @"IMCurrentTeamId";
static IMTeam *_currentTeam = nil;

+ (IMTeam *)currentTeam
{
    if (!_currentTeam)
    {
        NSString *cachedTeamId = [[NSUserDefaults standardUserDefaults] stringForKey:kIMCurrentTeamIdKey];
        if (cachedTeamId.length > 0)
        {
            _currentTeam = [IMTeam objectWithoutDataWithObjectId:cachedTeamId];
        }
    }
    return _currentTeam;
}

- (void)storeAsCurrentTeam
{
    _currentTeam = self;
    [[NSUserDefaults standardUserDefaults] setObject:self.objectId forKey:kIMCurrentTeamIdKey];
}

- (void)logout
{
    _currentTeam = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kIMCurrentTeamIdKey];
}

@end
