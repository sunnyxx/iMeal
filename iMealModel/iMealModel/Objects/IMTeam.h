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

@property (nonatomic, strong, readonly) IMMember *me;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) AVRelation *membersRelation;
@property (nonatomic, copy) NSArray /*IMMember*/*members;

@end
