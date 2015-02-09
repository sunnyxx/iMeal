//
//  IMTeamCell.m
//  iMeal
//
//  Created by sunnyxx on 14-8-3.
//
//

#import "IMTeamOverviewCell.h"
#import "IMTeam.h"
#import <UIImageView+PlayGIF.h>

@interface IMTeamOverviewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation IMTeamOverviewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    self.logoImageView.gifPath = path;
    [self.logoImageView startGIF];
}

- (void)setTeam:(IMTeam *)team
{
    _team = team;
    self.nameLabel.text = team.name ?: @"赶紧取个名字吧";
    self.signLabel.text = [NSString stringWithFormat:@"暗号:%@", team.sign ?: @"获取中..."];
}

@end
