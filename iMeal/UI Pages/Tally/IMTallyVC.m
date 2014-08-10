//
//  IMTallyVC.m
//  iMeal
//
//  Created by sunnyxx on 14-8-5.
//
//

#import "IMTallyVC.h"
#import "IMTallyRecordCell.h"
#import "IMTallyPublicItemCell.h"
#import "IMTallyMemberCell.h"
#import "IMServer+TeamSignals.h"

@interface IMTallyVC ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *finishButtonItem;
@property (nonatomic, copy) NSArray *costRecords;
@end

@implementation IMTallyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *records = [NSMutableArray array];
    for (IMMember *member in self.members)
    {
        IMMemberTally *record = [IMMemberTally new];
        record.member = member;
        record.date = [NSDate new];
        [records addObject:record];
    }
    self.costRecords = records;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - Table view data source

enum {
    kSectionPublicItem,
    kSectionMembers,
    kSectionCount
};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger[]){1, self.costRecords.count}[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGFloat[]){60.0f, 50.0f}[indexPath.section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kSectionPublicItem)
    {
        IMTallyPublicItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMTallyPublicItemCell xx_nibID] forIndexPath:indexPath];
        
        return cell;
    }
    else if (indexPath.section == kSectionMembers)
    {
        IMTallyMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMTallyMemberCell xx_nibID] forIndexPath:indexPath];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
