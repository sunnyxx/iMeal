//
//  IMTeamCreationVC.m
//  iMeal
//
//  Created by sunnyxx on 14-7-30.
//
//

#import "IMTeamCreationVC.h"
#import "IMServer.h"

@interface IMTeamCreationVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end

@implementation IMTeamCreationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    RACSignal *enableSignal = [self.nameTextField.rac_textSignal map:^id(NSString *value) {
        return @(value.length > 2);
    }];
    self.createButton.rac_command = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [[IMServer createTeamSignalWithTeamName:self.nameTextField.text] subscribeError:^(NSError *error) {
            
        } completed:^{
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateInitialViewController];
            [self presentViewController:vc animated:YES completion:nil];
        }];
        return [RACSignal empty];
    }];
    
    [[self rac_signalForSelector:@selector(viewDidAppear:)] subscribeNext:^(id x) {
        @strongify(self);
        [self.nameTextField becomeFirstResponder];
    }];
    
//    [[self.createButton.rac_command.executionSignals flatten] subscribeError:^(NSError *error) {
//        
//    } completed:^{
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *vc = [sb instantiateInitialViewController];
//        [self presentViewController:vc animated:YES completion:nil];
//    }];
//
//    [[[self.createButton rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value) {
//        return [IMServer createTeamSignalWithTeamName:self.nameTextField.text];
//    }] subscribeError:^(NSError *error) {
//        
//    } completed:^{
//        
//    }];;
}

@end
