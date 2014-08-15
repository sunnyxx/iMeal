//
//  IMTallyViewModel.h
//  iMeal
//
//  Created by sunnyxx on 14-8-13.
//
//

@class IMTeam;

@interface IMTallyViewModel : NSObject

- (instancetype)initWithTeam:(IMTeam *)team members:(NSArray *)members;

@property (nonatomic, strong, readonly) IMTeam *team;
@property (nonatomic, copy, readonly) NSArray *members;

/// Member select
@property (nonatomic, copy) NSArray *selectedMembersIndexPaths;

@end
