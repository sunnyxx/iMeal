//
//  IMSetup.m
//  iMeal
//
//  Created by 萨萨萨 on 15/3/2.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import "IMSetup.h"
#import <AVOSCloud/AVOSCloud.h>

#import "IMUser.h"
#import "IMTeam.h"
#import "IMRestaurant.h"
#import "IMBills.h"
#import "IMMoney.h"

@implementation IMSetup

+ (void)setup {
    [AVOSCloud setApplicationId:@"275snliuy6480kevj7g2shw36teiyztx0nme2wo5xldhmyim"
                      clientKey:@"vu8ipn1qu2z8f5wt6q966r4c9bi81ehuypml4etj3pyfxwky"];
    
    [IMUser registerSubclass];
    [IMTeam registerSubclass];
    [IMRestaurant registerSubclass];
    [IMBills registerSubclass];
    [IMMoney registerSubclass];
}

@end
