//
//  IMCostRecord.h
//  iMealModel
//
//  Created by sunnyxx on 14-7-30.
//
//

#import <AVOSCloud/AVOSCloud.h>

@class IMMember, IMRestaurant;
@interface IMCostRecord : AVObject <AVSubclassing>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) IMMember *member;
@property (nonatomic, strong) IMRestaurant *restaurant;
@property (nonatomic) CGFloat fromMoney;
@property (nonatomic) CGFloat costMoney;

@end
