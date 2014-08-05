//
//  IMMembersVC.m
//  iMeal
//
//  Created by sunnyxx on 14-7-29.
//
//

#import "IMMembersVC.h"
#import "IMChargeVC.h"
#import "IMTeamCell.h"
#import <XXNibBridge/XXNibBridge.h>
#import "IMTallyVC.h"
#import "IMServer.h"
@interface IMMembersVC ()
@property (nonatomic, copy) NSArray *members;

@end

enum {
    kSectionTeam,
    kSectionMembers,
    kSectionCount
};

@implementation IMMembersVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);

    // Refresh data when one of
    // 1. view will appear
    // 2. refresh control
    RACSignal *refreshControlSignal = [self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged];
    RACSignal *viewWillAppearSignal = [self rac_signalForSelector:@selector(viewWillAppear:)];
    // Merge
    [[RACSignal merge:@[refreshControlSignal, viewWillAppearSignal]] subscribeNext:^(id x) {
        
        // Refresh team data
//        IMTeam *team = [IMTeam currentTeam];
//        [team refreshInBackgroundWithBlock:^(AVObject *object, NSError *error) {
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kSectionTeam] withRowAnimation:UITableViewRowAnimationAutomatic];
//        }];
//        
        // Refresh member data
        [[IMServer allMembersSignalInCurrentTeam] subscribeNext:^(NSArray *members) {
            @strongify(self);
            [self.refreshControl endRefreshing];
            self.members = members;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kSectionMembers] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ChargeSegue"])
    {
        IMChargeVC *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        vc.charger = self.members[indexPath.row];
    }
    else if ([segue.identifier isEqualToString:@"TallySegue"])
    {
        UINavigationController *nav = segue.destinationViewController;
        IMTallyVC *vc = (IMTallyVC *)[nav topViewController];
        vc.team = [IMTeam currentTeam];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (const NSInteger[]){1, self.members.count + 1}[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (const CGFloat[]){80.0f, 50.0f}[indexPath.section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kSectionTeam) {
        IMTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMTeamCell xx_nibID] forIndexPath:indexPath];
        cell.team = [IMTeam currentTeam];
        return cell;
    }
    // Footer
    if (indexPath.row == self.members.count)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddMemberCell" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberCell" forIndexPath:indexPath];
        
        IMMember *member = self.members[indexPath.row];
        cell.textLabel.text = member.nickname;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.0f", member.money];
        return cell;
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
    }
}

#pragma mark - exit segue

- (IBAction)cancelRecord:(UIStoryboardSegue *)segue {}

@end
