//
//  IMOverviewVC.m
//  iMeal
//
//  Created by sunnyxx on 14-7-29.
//
//

#import "IMOverviewVC.h"
#import <XXNibBridge/XXNibBridge.h>
#import "IMChargeVC.h"
#import "IMTeamOverviewCell.h"
#import "IMMemberOverviewCell.h"
#import "IMTallyMemberSelectVC.h"
#import "IMServer+TeamSignals.h"
#import "IMMemberAddingVC.h"
#import "IMRouter.h"
#import <FLEXManager.h>

@interface IMOverviewVC ()
@property (nonatomic, strong) IMTeam *team;
@property (nonatomic, copy) NSArray *members;
@end

enum {
    kSectionTeam,
    kSectionMembers,
    kSectionLogout,
    kSectionCount
};

@implementation IMOverviewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    
    // Refresh data
    RACCommand *refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[[[IMServer refreshCurrentTeamSignal]
                   doNext:^(IMTeam *team) {
                       @strongify(self);
                       self.team = team;
                       NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:kSectionTeam];
                       [self.tableView reloadSections:indexSet
                                     withRowAnimation:UITableViewRowAnimationAutomatic];
                   }]
                   then:^RACSignal *{
                       return [IMServer allTeamMembersSignal];
                   }]
                   doNext:^(NSArray *members) {
                       @strongify(self);
                       [self.refreshControl endRefreshing];
                       self.members = members;
                       NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:kSectionMembers];
                       [self.tableView reloadSections:indexSet
                                     withRowAnimation:UITableViewRowAnimationAutomatic];
                   }];
        }];
    
    self.refreshControl.rac_command = refreshCommand;
    [self.refreshControl.rac_command execute:nil];
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
        IMTallyMemberSelectVC *vc = (IMTallyMemberSelectVC *)[nav topViewController];
        IMTallyViewModel *viewModel = [[IMTallyViewModel alloc] initWithTeam:self.team members:self.members];
        vc.viewModel = viewModel;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (const NSInteger[]){1, self.members.count + 1, 1}[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (const CGFloat[]){80.0f, 50.0f, 40.0f}[indexPath.section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kSectionTeam)
    {
        IMTeamOverviewCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMTeamOverviewCell xx_nibID] forIndexPath:indexPath];
        cell.team = [IMTeam currentTeam];
        return cell;
    }
    else if (indexPath.section == kSectionMembers)
    {
        // Footer
        if (indexPath.row == self.members.count)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddMemberCell" forIndexPath:indexPath];
            return cell;
        }
        else
        {
            IMMemberOverviewCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMMemberOverviewCell xx_nibID] forIndexPath:indexPath];
            
            IMMember *member = self.members[indexPath.row];
            cell.member = member;
            return cell;
        }
    }
    else if (indexPath.section == kSectionLogout)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogoutCell" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Select team cell
    if (indexPath.section == kSectionTeam)
    {
        UIActionSheet *as = [[UIActionSheet alloc]
                             initWithTitle:@"想干啥"
                             delegate:nil
                             cancelButtonTitle:@"不干啥"
                             destructiveButtonTitle:nil
                             otherButtonTitles:@"改个名", @"改个暗号", nil];
        [as showFromTabBar:self.tabBarController.tabBar];
        [as.rac_buttonClickedSignal
            subscribeNext:^(NSNumber *value) {
                NSInteger index = [value integerValue];
                if (index == 0) {
                 
                }
            }];
        
    }
    // Logout
    else if (indexPath.section == kSectionLogout)
    {
        UIActionSheet *as = [[UIActionSheet alloc]
                             initWithTitle:@"真要换个桌？"
                             delegate:nil
                             cancelButtonTitle:@"取消"
                             destructiveButtonTitle:@"确定"
                             otherButtonTitles:nil];
        [as showFromTabBar:self.tabBarController.tabBar];
        [as.rac_buttonClickedSignal
            subscribeNext:^(NSNumber *value) {
                NSInteger index = [value integerValue];
                if (index == 0) {
                    [[IMRouter globalRouter] logout];
                    [[IMTeam currentTeam] logout];
                }
            }];
    }
}

#pragma mark - Table view delete cell

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kSectionMembers &&
        indexPath.row != self.members.count)
    {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        @weakify(self);
        
        IMMember *member = self.members[indexPath.row];
        
        UIActionSheet *as = [[UIActionSheet alloc] init];
        as.title = [NSString stringWithFormat:@"确认移除%@？", member.nickname];
        
        [as addButtonWithTitle:@"移除"];
        [as addButtonWithTitle:@"取消"];
        as.destructiveButtonIndex = 0;
        as.cancelButtonIndex = 1;
        [as showFromTabBar:self.tabBarController.tabBar];
        
        // Remove action
        @weakify(as);
        [[as.rac_buttonClickedSignal
            flattenMap:^RACStream *(NSNumber *index) {
                @strongify(as);
                if ([index integerValue] == as.cancelButtonIndex) {
                    // Remove delete button
                    [tableView setEditing:NO animated:YES];
                    // Stop signal chain
                    return [RACSignal never];
                }
                return [IMServer removeMemberSignal:member];
            }]
            subscribeCompleted:^{
                @strongify(self);
                NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                    return ![evaluatedObject isEqual:member];
                }];
                self.members = [self.members filteredArrayUsingPredicate:predicate];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        
    }
}

- (IBAction)flexToolBarAction:(id)sender
{
    [[FLEXManager sharedManager] showExplorer];
}

#pragma mark - Unwind segues

- (IBAction)unwindCancelRecord:(UIStoryboardSegue *)segue {}
- (IBAction)unwindCancelTally:(UIStoryboardSegue *)segue {}
- (IBAction)unwindNewMemberAdded:(UIStoryboardSegue *)segue
{
    IMMemberAddingVC *vc = segue.sourceViewController;
    self.members = [self.members arrayByAddingObject:vc.addedMember];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.members.count - 1 inSection:kSectionMembers];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
