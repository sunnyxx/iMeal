//
//  IMTeamTally.h
//  iMealModel
//
//  Created by sunnyxx on 14-8-7.
//
//

#import <AVOSCloud/AVOSCloud.h>

@class IMTeam;
@interface IMTeamTally : AVObject <AVSubclassing>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) IMTeam *team;
@property (nonatomic, strong) AVRelation *memberTallies;

@property (nonatomic) CGFloat totalMoney;
@property (nonatomic) CGFloat publicMoney;
@property (nonatomic) CGFloat bufferMoney;

@end
