//
//  IMChargeRecord.h
//  iMealModel
//
//  Created by sunnyxx on 14-7-30.
//
//

#import <AVOSCloud/AVOSCloud.h>

@class IMMember, IMTeam;
@interface IMChargeRecord : AVObject <AVSubclassing>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) IMTeam *team;
@property (nonatomic, strong) IMMember *charger;
@property (nonatomic, strong) IMMember *receiver;
@property (nonatomic) CGFloat money;

@end
