//
//  IMTallyMemberSelectCell.m
//  iMeal
//
//  Created by sunnyxx on 14-8-13.
//
//

#import "IMTallyMemberSelectCell.h"
#import "IMMember.h"

@implementation IMTallyMemberSelectCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (void)setMember:(IMMember *)member
{
    _member = member;
    self.textLabel.text = member.nickname;
}

@end
