//
//  MFTeam.h
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//  
//

#import <AVOSCloud/AVOSCloud.h>

@class IMMember;

@interface IMTeam : AVObject <AVSubclassing>

+ (IMTeam *)currentTeam;
- (void)storeAsCurrentTeam;

@property (nonatomic, copy) NSString *name;

/// Team number
@property (nonatomic, copy) NSString *number;
@property (nonatomic, strong) AVRelation *members;
@property (nonatomic, strong) AVRelation *restaurants;

/// Last member that received money from others
@property (nonatomic, strong) IMMember *receiver;

@end
