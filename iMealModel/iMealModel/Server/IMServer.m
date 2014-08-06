//
//  IMServer.m
//  iMealModel
//
//  Created by sunnyxx on 14-7-24.
//
//

#import "IMServer.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation IMServer

+ (void)setup
{
    // This method must be called before [AVOSCloud setApplicationId:clientKey:]
    [IMMember registerSubclass];
    [IMTeam registerSubclass];
    [IMRestaurant registerSubclass];
    [IMChargeRecord registerSubclass];
    [IMMemberTally registerSubclass];
    
    [AVOSCloud setApplicationId:@"lwqrtun88ejwd9omplkeivhtiu9vv3zzo60ngt64qygtkdvp"
                      clientKey:@"w2xg21mruyuvr44yjmimg4o952rptlb0c40qwur33s89w2el"];
}

@end
