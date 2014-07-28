//
//  MFTeam.m
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//
//

#import "IMTeam.h"

@implementation IMTeam

@dynamic name, members;

+ (IMTeam *)currentTeam
{
    IMTeam *team = [IMTeam objectWithoutDataWithObjectId:@"53d5f08ae4b01e504b21d8fd"];
    [team fetch];
    return team;
}

@end
