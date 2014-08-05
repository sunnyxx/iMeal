//
//  IMTallyVC.m
//  iMeal
//
//  Created by sunnyxx on 14-8-5.
//
//

#import "IMTallyVC.h"
#import "IMTallyMemberCell.h"
#import "IMServer.h"

@interface IMTallyVC ()
@property (nonatomic, copy) NSArray *members;
@end

@implementation IMTallyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    [[IMServer allMembersSignalInCurrentTeam] subscribeNext:^(NSArray *members) {
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
    IMTallyMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMTallyMemberCell xx_nibID] forIndexPath:indexPath];
    IMMember *member = self.members[indexPath.row];
    cell.member = member;
    return cell;
}


@end
