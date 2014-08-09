//
//  IMTeamEnterVC.m
//  iMeal
//
//  Created by sunnyxx on 14-8-6.
//
//

#import "IMTeamEnterVC.h"
#import "IMServer+TeamSignals.h"
#import "IMRouter.h"

@interface IMTeamEnterVC ()
@property (weak, nonatomic) IBOutlet UITextField *signTextField;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@end

@implementation IMTeamEnterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    
    // Enter button enable state
    RACSignal *enable = [[self.signTextField.rac_textSignal
        distinctUntilChanged]
        map:^id(NSString *value) {
            return @(value.length > 1);
        }];
    
    // Enter button command
    RACCommand *command = [[RACCommand alloc] initWithEnabled:enable signalBlock:^RACSignal *(id input) {
        return [[[IMServer enterTeamSignalWithSign:self.signTextField.text]
                   doError:^(NSError *error) {
                       // TODO: not exsit team
                   }]
                   doCompleted:^{
                       
                       // Router into
                       [[IMRouter globalRouter] login];
                   }];
    }];
    self.enterButton.rac_command = command;
    
    // Pop keyboard
    [[self rac_signalForSelector:@selector(viewWillAppear:)]
        subscribeNext:^(id x) {
            @strongify(self);
            [self.signTextField becomeFirstResponder];
        }];
}

@end
