//
//  IMChargeReceiverSelectionVC.h
//  iMeal
//
//  Created by sunnyxx on 14-8-5.
//
//

#import <UIKit/UIKit.h>

@class IMMember;
@interface IMChargeReceiverVC : UITableViewController

@property (nonatomic, strong) IMMember *charger; // Input
@property (nonatomic, strong, readonly) IMMember *receiver; // Output

@end
