//
//  IMQRCodeGeneratorViewController.m
//  iMeal
//
//  Created by sunnyxx on 15/2/28.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import "IMQRCodeGeneratorViewController.h"

@interface IMQRCodeGeneratorViewController ()
@property (nonatomic, weak) IBOutlet UILabel *teamNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *codeImageView;
@end

@implementation IMQRCodeGeneratorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.teamNameLabel.text = @"Sark小组二维码";
    self.codeImageView.image = [self QRCodeImageFromString:@"sark是gay"];
}

- (UIImage *)QRCodeImageFromString:(NSString *)string
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:stringData forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    
    CIImage *originalImage = filter.outputImage;
    CGAffineTransform transform = CGAffineTransformMakeScale(10, 10); // Scale 10x
    CIImage *scaledImage = [originalImage imageByApplyingTransform:transform];
    
    return [UIImage imageWithCIImage:scaledImage];
}

@end
