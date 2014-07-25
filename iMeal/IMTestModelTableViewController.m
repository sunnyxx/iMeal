//
//  IMTestModelTableViewController.m
//  iMeal
//
//  Created by sunnyxx on 14-7-24.
//
//

#import "IMTestModelTableViewController.h"
#import "IMServer.h"
#import "IMModelObjects.h"

@interface IMTestModelTableViewController ()
@property (nonatomic, readwrite, copy) NSArray *array;

@end

@implementation IMTestModelTableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *arr = [@[@1, @2] mutableCopy];
    _array = arr;
    
    
    IMTeam *team = [IMTeam new];
    team.name = @"sunnyxx's team";
    IMAdministrator *admin = [IMAdministrator new];
    
    [[IMServer createTeam:team byAdministrator:admin] subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
    
}

@end
