//
//  IMMember.h
//  iMealModel
//
//  Created by sunnyxx on 14-7-23.
//  
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMMember : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *nickname;

/// Current balance of this member
@property (nonatomic) CGFloat money;

/// Team money that this member kept
/// Added after receiving from others
@property (nonatomic) CGFloat keptMoney;

@end
