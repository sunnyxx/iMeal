//
//  IMTallyVC.m
//  iMeal
//
//  Created by sunnyxx on 14-8-5.
//
//

#import "IMTallyVC.h"
#import "IMTallyRecordCell.h"
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.costRecords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IMTallyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMTallyRecordCell xx_nibID] forIndexPath:indexPath];
    IMMemberTally *record = self.costRecords[indexPath.row];
    cell.record = record;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
