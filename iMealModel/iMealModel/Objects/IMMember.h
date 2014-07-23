//
//  MFTeamMember.h
//  MealFundModel
//
//  Created by sunnyxx on 14-7-23.
//  
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMMember : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *nickname;

@end
