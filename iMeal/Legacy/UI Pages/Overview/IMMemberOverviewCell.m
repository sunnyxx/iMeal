//
//  IMMemberOverviewCell.m
//  iMeal
//
//  Created by sunnyxx on 14-8-7.
//
//

#import "IMMemberOverviewCell.h"
#import "IMMember.h"
#import "IMFormatDisplay.h"
#import "UILabel+IMMoneyLabel.h"
#import "IMMoneyLabel.h"

@interface IMMemberOverviewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet IMMoneyLabel *moneyLabel;
@property (weak, nonatomic) IBOutlet IMMoneyLabel *keptMoneyLabel;

@end

@implementation IMMemberOverviewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    

}

- (void)setMember:(IMMember *)member
{
    _member = member;
    RAC(self.nicknameLabel, text) = [[[
        RACObserve(member, nickname)
        ignore:nil]
        map:^id(id value) {
            return value;
        }]
        takeUntil:self.rac_prepareForReuseSignal
    ];
    
    RAC(self.moneyLabel, money) = [[
        RACObserve(member, money)
        ignore:nil]
        takeUntil:self.rac_prepareForReuseSignal
    ];
    RAC(self.keptMoneyLabel, keptMoney) = [[[
        RACObserve(member, keptMoney)
        ignore:nil]
        doNext:^(NSNumber *value) {
            self.keptMoneyLabel.hidden = ([value floatValue] <= 0);
        }]
        takeUntil:self.rac_prepareForReuseSignal
    ];
}

@end
