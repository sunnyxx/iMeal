//
//  IMMemberAddingVC.m
//  iMeal
//
//  Created by sunnyxx on 14-8-3.
//
//

#import "IMMemberAddingVC.h"
#import "IMServer.h"

@interface IMMemberAddingVC ()
@property (nonatomic, weak) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@end

@implementation IMMemberAddingVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    RACSignal *enable = [RACSignal return:@YES];
    self.addButton.rac_command = [[RACCommand alloc] initWithEnabled:enable signalBlock:^RACSignal *(id _) {
        @strongify(self);
        return [[IMServer addMemberSignalWithNickname:self.nicknameTextField.text]
            doCompleted:^{
                [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
    [[self rac_signalForSelector:@selector(viewDidAppear:)] subscribeNext:^(id x) {
        @strongify(self);
        [self.nicknameTextField becomeFirstResponder];
    }];
}
    
@end
