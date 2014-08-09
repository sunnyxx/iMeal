//
//  IMMoneyLabel.m
//  iMeal
//
//  Created by sunnyxx on 14-8-9.
//
//

#import "IMMoneyLabel.h"
#import "IMFormatDisplay.h"

typedef NS_ENUM(NSInteger, IMMoneyLabelIconType)
{
    IMMoneyLabelIconTypeMoney,
    IMMoneyLabelIconTypeKeptMoney
};

@interface IMMoneyLabel ()
@property (nonatomic) CGSize moneyIconSize;
@property (nonatomic) IMMoneyLabelIconType iconType;
@end

@implementation IMMoneyLabel

- (void)setMoney:(CGFloat)money
{
    _money = money;
    self.text = IMMoneyDisplay(money);
    self.iconType = IMMoneyLabelIconTypeMoney;
}

- (void)setKeptMoney:(CGFloat)keptMoney
{
    _keptMoney = keptMoney;
    self.text = IMMoneyDisplay(keptMoney);
    self.iconType = IMMoneyLabelIconTypeKeptMoney;
}

#pragma mark - Override

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect defaultRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    CGSize iconSize = self.moneyIconSize;
    CGRect rect = CGRectMake(iconSize.width, 0, CGRectGetWidth(defaultRect) + iconSize.width, CGRectGetHeight(defaultRect));
    return rect;
}

- (void)drawTextInRect:(CGRect)rect
{
    UIImage *image = [self imageWithIconType:self.iconType];
    CGRect imageFrame = {.size = self.moneyIconSize};
    [image drawInRect:imageFrame];
    CGRect textRect = CGRectOffset(rect, CGRectGetHeight(rect), 0);
    [super drawTextInRect:textRect];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    return size;
}

#pragma mark - Helpers

- (CGSize)moneyIconSize
{
    return CGSizeMake(self.font.lineHeight, self.font.lineHeight);
}

- (UIImage *)imageWithIconType:(IMMoneyLabelIconType)type
{
    NSString *name = @[@"coin", @"star"][type];
    return [UIImage imageNamed:name];
}

@end
