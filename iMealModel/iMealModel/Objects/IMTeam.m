//
//  MFTeam.m
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//
//

#import "IMTeam.h"
#import "IMMember.h"

NSString *const kIMCurrentTeamIdKey = @"CurrentTeamId";

@implementation IMTeam

@dynamic name, number, members, restaurants, receiver;

#pragma mark - AVSubclassing

+ (NSString *)parseClassName
{
    return @"Team";
}

#pragma mark - Current team

static IMTeam *_currentTeam = nil;

+ (IMTeam *)currentTeam
{
    if (_currentTeam)
    {
        return _currentTeam;
    }
    
    NSString *teamId = [[NSUserDefaults standardUserDefaults] objectForKey:kIMCurrentTeamIdKey];
    if (teamId)
    {
        AVQuery *query = [IMTeam query];
        [query includeKey:@"receiver"];
        AVObject *object = [query getObjectWithId:teamId];
        
        if (object)
        {
            _currentTeam = (IMTeam *)object;
            return _currentTeam;
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kIMCurrentTeamIdKey];
            _currentTeam = nil;
        }
    }
    
    return nil;
}

- (void)storeAsCurrentTeam
{
    _currentTeam = self;
    
    if (self.objectId)
    {
        [[NSUserDefaults standardUserDefaults] setObject:self.objectId forKey:kIMCurrentTeamIdKey];
    }
}

@end
