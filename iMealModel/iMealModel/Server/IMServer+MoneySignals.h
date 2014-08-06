//
//  IMServer+MoneySignals.h
//  iMealModel
//
//  Created by sunnyxx on 14-8-6.
//
//

#import "IMServer.h"

@interface IMServer (MoneySignals)

/// Signal for charge money in.
/// This will:
/// 1. Build a `IMChargeRecord` object to record it
/// 2. charger.money += money
/// 3. receiver.money -= money
+ (RACSignal *)chargeSignalWithCharger:(IMMember *)charger
                              receiver:(IMMember *)receiver
                                 money:(CGFloat)money;

/// Signal for tally once
+ (RACSignal *)tallySignalWithCostRecords:(NSArray *)records;

@end
