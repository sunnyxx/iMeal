//
//  IMTeamCreationVC.m
//  iMeal
//
//  Created by sunnyxx on 14-7-30.
//
//

#import "IMTeamCreationVC.h"
#import "IMServer+TeamSignals.h"
#import "IMProgressHUD.h"

@interface IMTeamCreationVC ()

@property (weak, nonatomic) IBOutlet UITextField *teamCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end

@implementation IMTeamCreationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    
    RACSignal *enableSignal = [self.teamCodeTextField.rac_textSignal map:^id(NSString *value) {
        return @(value.length > 2);
    }];
    
    // Button command
    RACCommand *command = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [IMServer createTeamSignalWithSign:self.teamCodeTextField.text];
    }];
    
    // Excuting
    [[command executing] subscribeNext:^(NSNumber *excuting) {

    }];
    
    // Complete
    [[command executionSignals]
         subscribeNext:^(RACSignal *signal) {
             [signal subscribeCompleted:^{
                 @strongify(self);
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [sb instantiateInitialViewController];
                [self presentViewController:vc animated:YES completion:nil];
            }];
         }];
    
    // TODO: Error handler
    [command.errors subscribeNext:^(NSError *error) {
        
    }];
    
    self.createButton.rac_command = command;
    
    [[self rac_signalForSelector:@selector(viewWillAppear:)]
        subscribeNext:^(id x) {
            @strongify(self);
            [self.teamCodeTextField becomeFirstResponder];
        }];

}

@end
