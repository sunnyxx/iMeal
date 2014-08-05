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
@property (weak, nonatomic) IBOutlet UILabel *teamNumberLabel;

@end

@implementation IMTeamCell

- (void)setTeam:(IMTeam *)team
{
    _team = team;
    self.teamNameLabel.text = team.name;
    self.teamNumberLabel.text = [NSString stringWithFormat:@"桌号:%@", team.number];
}

@end
