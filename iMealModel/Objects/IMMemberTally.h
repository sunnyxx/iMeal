//
//  IMMemberTally.h
//  iMealModel
//
//  Created by sunnyxx on 14-7-30.
//
//

#import <AVOSCloud/AVOSCloud.h>

@class IMMember, IMRestaurant;
@interface IMMemberTally : AVObject <AVSubclassing>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) IMMember *member;
@property (nonatomic, strong) IMMember *payer;
@property (nonatomic, strong) IMRestaurant *restaurant;
@property (nonatomic) CGFloat money;

@end
