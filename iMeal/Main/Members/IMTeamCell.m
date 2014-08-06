//
//  IMTeamCell.m
//  iMeal
//
//  Created by sunnyxx on 14-8-3.
//
//

#import "IMTeamCell.h"
#import "IMTeam.h"

@interface IMTeamCell ()

@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamCodeLabel;

@end

@implementation IMTeamCell

- (void)setTeam:(IMTeam *)team
{
    _team = team;
    self.teamNameLabel.text = team.name ?: @"赶紧取个名字吧";
    self.teamCodeLabel.text = [NSString stringWithFormat:@"暗号:%@", team.sign];
}

@end
