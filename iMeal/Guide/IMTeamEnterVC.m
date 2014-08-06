//
//  IMTeamEnterVC.m
//  iMeal
//
//  Created by sunnyxx on 14-8-6.
//
//

#import "IMTeamEnterVC.h"
#import "IMServer+TeamSignals.h"

@interface IMTeamEnterVC ()
@property (weak, nonatomic) IBOutlet UITextField *teamNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@end

@implementation IMTeamEnterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    RACSignal *enable = [[self.teamNumberTextField.rac_textSignal
//        distinctUntilChanged]
//        map:^id(NSString *value) {
//            return @(value.length == [IMTeam teamNumberLength]);
//        }];
//    RACCommand *command = [[RACCommand alloc] initWithEnabled:enable signalBlock:^RACSignal *(id input) {
//        return [IMServer 
//    }];
}

@end
