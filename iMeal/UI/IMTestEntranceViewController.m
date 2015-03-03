//
//  IMTestEntranceViewController.m
//  iMeal
//
//  Created by sunnyxx on 15/2/27.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import "IMTestEntranceViewController.h"
#import "IMQRCodeRecognizerViewController.h"
#import "IMQRCodeGeneratorViewController.h"
#import <XXNibBridge.h>

@interface IMTestEntranceViewController ()

@end

@implementation IMTestEntranceViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            IMQRCodeGeneratorViewController *vc = [IMQRCodeGeneratorViewController xx_instantiateFromStoryboardNamed:@"QRCode"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 1: {
            IMQRCodeRecognizerViewController *vc = [IMQRCodeRecognizerViewController xx_instantiateFromStoryboardNamed:@"QRCode"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
            
        default:
            break;
    }
}

@end
