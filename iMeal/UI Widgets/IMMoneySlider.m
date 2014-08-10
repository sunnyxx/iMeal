//
//  IMMoneySlider.m
//  iMeal
//
//  Created by sunnyxx on 14-8-10.
//
//

#import "IMMoneySlider.h"

@interface IMMoneySlider ()

@end

@implementation IMMoneySlider

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderValueChanged:(id)sender
{
    
}

- (RACSignal *)moneySignal
{
    return nil;
}

@end
