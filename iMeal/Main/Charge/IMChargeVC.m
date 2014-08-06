//
//  IMChargeVC.m
//  iMeal
//
//  Created by sunnyxx on 14-7-30.
//
//

#import "IMChargeVC.h"
#import <AVCloud.h>
#import "IMMember.h"
#import "IMChargeRecord.h"
#import "IMChargeReceiverVC.h"
#import "IMServer+MoneySignals.h"

@interface IMChargeVC ()
@property (weak, nonatomic) IBOutlet UIButton *moneyReceiverButton;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *originalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultMoneyLabel;

@property (nonatomic, strong) IMChargeRecord *record;
@property (nonatomic, strong) IMMember *receiver; // Who takes the money

@end

@implementation IMChargeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // Navigation bar title
    self.title = [NSString stringWithFormat:@"给%@冲钱", self.charger.nickname];
    
    // Money receiver
    [[[RACObserve(self, receiver)
        ignore:nil]
        distinctUntilChanged]
        subscribeNext:^(IMMember *receiver) {
            @strongify(self);
            if (receiver.nickname) {
                [self.moneyReceiverButton setTitle:receiver.nickname forState:UIControlStateNormal];
            }
    }];
    // Set the last receiver in current team
    self.receiver = [IMTeam currentTeam].receiver;
    
    // Make the equation
    // `original + input = result`
    self.originalMoneyLabel.text = [NSString stringWithFormat:@"￥%.1f", self.charger.money];
    RAC(self.resultMoneyLabel, text) = [self.moneyTextField.rac_textSignal map:^id(NSString *value) {
        @strongify(self);
        return [NSString stringWithFormat:@"￥%.1f", self.charger.money + [value floatValue]];
    }];
    
    // Confirm button enable when:
    // 1. Have a recevier
    // 2. Have input money
    RACSignal *enable = [[RACSignal
        combineLatest:@[self.moneyTextField.rac_textSignal,
                        RACObserve(self, receiver)]
        reduce:^id(NSString *text, IMMember *receiver){
            return (text.length > 0 && receiver) ? @YES : @NO;
    }] doNext:^(NSNumber *enable) {
        // Add custom disable effect
        self.confirmButton.alpha = [enable boolValue] ? 1.0f : 0.5f;
    }];
    
    self.confirmButton.rac_command = [[RACCommand alloc] initWithEnabled:enable signalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal defer:^RACSignal *{
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                // Request
                CGFloat chargedMoney = [self.moneyTextField.text floatValue];
                [[IMServer
                    chargeSignalWithCharger:self.charger
                                   receiver:self.receiver
                                      money:chargedMoney]
                    subscribeError:^(NSError *error) {
                        [subscriber sendError:error];
                    } completed:^{
                        [subscriber sendCompleted];
                    }];
                return nil;
            }];
        }];
    }];
    
    // Pop when all requests done
    [self.confirmButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
        [signal subscribeCompleted:^{
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
    // Loading state
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"充值中" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [[self.confirmButton.rac_command.executing
        skip:1]
        subscribeNext:^(NSNumber *value) {
            if ([value boolValue]) {
                [alert show];
            } else {
                [alert dismissWithClickedButtonIndex:0 animated:YES];
            }
        }];
    
    // Error state
    [self.confirmButton.rac_command.errors subscribeNext:^(NSError *error) {
        alert.title = error.localizedDescription;
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }];
    
    // Pop keyboard automatically
    [[self rac_signalForSelector:@selector(viewDidAppear:)] subscribeNext:^(id _) {
        @strongify(self);
        [self.moneyTextField becomeFirstResponder];
    }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nav = segue.destinationViewController;
    IMChargeReceiverVC *vc = (IMChargeReceiverVC *)nav.topViewController;
    vc.charger = self.charger;
}

- (IBAction)unwindFromChargeReceiverVC:(UIStoryboardSegue *)segue
{
    // Get back the data
    IMChargeReceiverVC *vc = segue.sourceViewController;
    self.receiver = vc.receiver;
}

- (IBAction)unwindFromChargeReceiverVCCanceled:(UIStoryboardSegue *)segue {}

@end
