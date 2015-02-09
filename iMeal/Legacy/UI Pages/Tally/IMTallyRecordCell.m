//
//  IMTallyMemberCell.m
//  iMeal
//
//  Created by sunnyxx on 14-8-5.
//
//

#import "IMTallyRecordCell.h"
#import "IMMemberTally.h"
#import "IMMember.h"

@interface IMTallyRecordCell ()
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *paidIcon;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (weak, nonatomic) IBOutlet UIView *moneyGradientView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyGradientViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation IMTallyRecordCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Bind data
    RAC(self.nicknameLabel, text) = [[RACObserve(self, record) ignore:nil] map:^id(IMMemberTally *record) {
        return record.member.nickname;
    }];
    
    // Gradient view
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.contentView.bounds;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = @[(id)[UIColor colorWithRed:0.296 green:0.958 blue:0.071 alpha:0.910].CGColor,
                        (id)[UIColor colorWithRed:1.000 green:0.263 blue:0.256 alpha:1.000].CGColor];
    self.moneyGradientView.layer.masksToBounds = YES;
    [self.moneyGradientView.layer insertSublayer:gradient atIndex:0];
    self.moneyGradientView.alpha = 0.5f;
    
    // Pan gesture
    self.panGesture = [[UIPanGestureRecognizer alloc] init];
    [self.contentView addGestureRecognizer:self.panGesture];
    [[self.panGesture rac_gestureSignal] subscribeNext:^(UIPanGestureRecognizer *recognizer) {
        CGPoint location = [recognizer locationInView:recognizer.view];
        CGPoint point = [recognizer translationInView:recognizer.view];
        switch (recognizer.state) {
            case UIGestureRecognizerStateBegan: {
                self.moneyGradientView.alpha = 1.0f;
            } break;
            case UIGestureRecognizerStateChanged: {
                CGFloat minX = CGRectGetMaxX(self.nicknameLabel.frame);
                location.x = MAX(minX, location.x);
                self.moneyGradientViewWidthConstraint.constant = location.x;
                [self.contentView updateConstraintsIfNeeded];
                
                CGFloat money = [self moneyAtLocationX:location.x];
                self.moneyLabel.text = [NSString stringWithFormat:@"￥%.1f", money];
                if (money == 0)
                {
                    self.moneyGradientView.alpha = 0;
                }
            } break;
                
            case UIGestureRecognizerStateEnded: {
                self.moneyGradientView.alpha = 0.5f;
            } break;
            default:
                break;
        }
    }];
    
}

- (CGFloat)moneyAtLocationX:(CGFloat)x
{
    if (x < 100)
    {
        return 0;
    }
    else
    {
        CGFloat y = 0.02f * powf(x - 100, 2);
        y = floorf(y);
        return y;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.paidIcon.hidden = !selected;
}

@end
