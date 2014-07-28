//
//  IMAddMemberViewModel.m
//  iMeal
//
//  Created by sunnyxx on 14-7-29.
//
//

#import "IMAddMemberViewModel.h"
#import "IMServer.h"

@interface IMAddMemberViewModel ()
@property (nonatomic, weak) IBOutlet UIViewController *viewController;
@property (nonatomic, weak) IBOutlet UITextField *nicknameTextField;
@end

@implementation IMAddMemberViewModel

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (IBAction)doneAction:(id)sender
{
    [[IMServer addMemberIntoCurrentTeamWithNickname:self.nicknameTextField.text] subscribeCompleted:^{
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }];;
}

@end
