//
//  IMRestaurant.h
//  iMealModel
//
//  Created by sunnyxx on 14-7-30.
//
//

#import <AVOSCloud/AVOSCloud.h>

@interface IMRestaurant : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) AVGeoPoint *location;

@end
