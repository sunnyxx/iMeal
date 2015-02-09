//
//  IMMemberAddingVC.h
//  iMeal
//
//  Created by sunnyxx on 14-8-3.
//
//

#import <UIKit/UIKit.h>

@class IMTeam, IMMember;
@interface IMMemberAddingVC : UIViewController

@property (nonatomic, strong) IMTeam *team; // Input
@property (nonatomic, strong) IMMember *addedMember; // Output

@end
