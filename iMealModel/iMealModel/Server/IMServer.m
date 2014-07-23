//
//  IMServer.m
//  iMealModel
//
//  Created by sunnyxx on 14-7-24.
//
//

#import "IMServer.h"
#import <AVOSCloud/AVOSCloud.h>
#import "IMModelObjects.h"

@implementation IMServer

+ (void)setup
{
    [AVOSCloud setApplicationId:@"lwqrtun88ejwd9omplkeivhtiu9vv3zzo60ngt64qygtkdvp"
                      clientKey:@"w2xg21mruyuvr44yjmimg4o952rptlb0c40qwur33s89w2el"];
    
    [IMMember registerSubclass];
}

+ (RACSignal *)requestCreateTeam:(IMTeam *)team byAdministrator:(IMAdministrator *)admin
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AVObject *object = [AVObject objectWithClassName:@"Team"];
        object[@"name"] = team.name;
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            }
            else {
                [subscriber sendCompleted];
            }
        }];
        
        return nil;
    }];
}

@end
