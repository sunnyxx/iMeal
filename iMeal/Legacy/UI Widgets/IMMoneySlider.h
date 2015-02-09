//
//  IMMoneySlider.h
//  iMeal
//
//  Created by sunnyxx on 14-8-10.
//
//

#import <UIKit/UIKit.h>

@interface IMMoneySlider : UISlider

- (RACSignal *)moneySignal;

@end
