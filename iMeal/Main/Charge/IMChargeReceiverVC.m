//
//  IMChargeReceiverSelectionVC.m
//  iMeal
//
//  Created by sunnyxx on 14-8-5.
//
//

#import "IMChargeReceiverVC.h"
#import "IMServer+TeamSignals.h"

@interface IMChargeReceiverVC ()
@property (nonatomic, copy) NSArray *members;
@end

@implementation IMChargeReceiverVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    [[[IMServer allTeamMembersSignal]
        map:^id(NSArray *members) {
        // Filter charger
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF != %@)", self.charger];
        return [members filteredArrayUsingPredicate:predicate];
    }] subscribeNext:^(NSArray *members) {
        @strongify(self);
        self.members = members;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiverCell" forIndexPath:indexPath];
    IMMember *member = self.members[indexPath.row];
    cell.textLabel.text = member.nickname;
    RAC(cell.accessoryView, hidden) = [[RACObserve(cell, isSelected) not] takeUntil:cell.rac_prepareForReuseSignal];;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    self->_receiver = self.members[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
}


@end
