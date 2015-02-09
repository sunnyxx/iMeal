//
//  IMTallyViewModel.m
//  iMeal
//
//  Created by sunnyxx on 14-8-13.
//
//

#import "IMTallyViewModel.h"

@interface IMTallyViewModel ()

@property (nonatomic, strong) IMTeam *team;
@property (nonatomic, copy) NSArray *members;

@end

@implementation IMTallyViewModel

- (instancetype)initWithTeam:(IMTeam *)team members:(NSArray *)members
{
    self = [super init];
    if (self)
    {
        self.team = team;
        self.members = members;
    }
    return self;
}

@end
