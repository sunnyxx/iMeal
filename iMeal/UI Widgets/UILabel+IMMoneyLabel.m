//
//  UILabel+IMMoneyLabel.m
//  iMeal
//
//  Created by sunnyxx on 14-8-9.
//
//

#import "UILabel+IMMoneyLabel.h"
#import "IMFormatDisplay.h"

@implementation UILabel (IMMoneyLabel)
@dynamic im_money;

- (void)setIm_money:(CGFloat)im_money
{
    // Image attachment
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"coin"];
    attach.bounds = CGRectMake(0, 0, 20, 20);
    
    // Combine
    NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:attach];
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] initWithString:IMMoneyDisplay(im_money)];
    [resultString insertAttributedString:imageString atIndex:0];
    self.attributedText = resultString;
    
    self.backgroundColor = [UIColor blueColor];
    // KVO support
    [self willChangeValueForKey:@"im_money"];
    [self didChangeValueForKey:@"im_money"];
}

- (CGFloat)im_money
{
    return 0;
}

@end
