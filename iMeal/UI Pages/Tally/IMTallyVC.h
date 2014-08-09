//
//  IMTallyVC.h
//  iMeal
//
//  Created by sunnyxx on 14-8-5.
//
//

#import <UIKit/UIKit.h>

@class IMTeam;
@interface IMTallyVC : UITableViewController

@property (nonatomic, strong) IMTeam *team;
@property (nonatomic, copy) NSArray *members;

@end
