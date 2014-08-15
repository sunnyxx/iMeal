//
//  IMTallyMemberSelectVC.m
//  iMeal
//
//  Created by sunnyxx on 14-8-13.
//
//

#import "IMTallyMemberSelectVC.h"
#import "IMTallyMemberSelectCell.h"
#import "IMMember.h"
#import "IMTallyVC.h"

@interface IMTallyMemberSelectVC ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButtonItem;

@end

@implementation IMTallyMemberSelectVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Cannot go next when non-selected
    RAC(self.nextButtonItem, enabled) =
    [RACObserve(self.viewModel, selectedMembersIndexPaths)
        map:^id(NSArray *value) {
            return value.count > 0 ? @YES : @NO;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TallyNextSegue"])
    {
        // Pass by view model
        IMTallyVC *vc = segue.destinationViewController;
        vc.viewModel = self.viewModel;
    }
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IMTallyMemberSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMTallyMemberSelectCell xx_nibID] forIndexPath:indexPath];
    IMMember *member = self.viewModel.members[indexPath.row];
    cell.member = member;
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.viewModel.selectedMembersIndexPaths = [self.tableView indexPathsForSelectedRows];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.viewModel.selectedMembersIndexPaths = [self.tableView indexPathsForSelectedRows];
}

@end
