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
#import <UIImageView-PlayGIF/UIImageView+PlayGIF.h>

@interface IMTestModelTableViewController ()
@property (nonatomic, readwrite, copy) NSArray *array;

@end

@implementation IMTestModelTableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    imageView.gifPath = path;
    imageView.center = tableView.center;
    [tableView addSubview:imageView];
    [imageView startGIF];
    self.navigationItem.titleView = imageView;
    
    IMTeam *team = [IMTeam new];
    team.name = @"sunnyxx's team";
    IMAdministrator *admin = [IMAdministrator new];
    
    [[IMServer createTeam:team byAdministrator:admin] subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
    
}

@end
