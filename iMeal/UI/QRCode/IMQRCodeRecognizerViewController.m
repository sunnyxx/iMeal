//
//  IMQRCodeRecognizerViewController.m
//  iMeal
//
//  Created by sunnyxx on 15/2/27.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#import "IMQRCodeRecognizerViewController.h"

@import AVFoundation;

@interface IMQRCodeRecognizerViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation IMQRCodeRecognizerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [self generateQRCodeWithString:@"www.baidu.com"];
    self.codeImageView.image = image;
    
    [self startReading];
}

- (UIImage *)generateQRCodeWithString:(NSString *)string
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:stringData forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    
    CIImage *originalImage = filter.outputImage;
    CGAffineTransform transform = CGAffineTransformMakeScale(5, 5);
    CIImage *scaledImage = [originalImage imageByApplyingTransform:transform];
    
    return [UIImage imageWithCIImage:scaledImage];
}

- (BOOL)startReading
{
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t outputQueue = dispatch_queue_create("outputQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:outputQueue];
    [captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.view.layer.bounds];
    [self.view.layer addSublayer:self.videoPreviewLayer];
    
    [self.captureSession startRunning];
    
    return YES;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
//    if (!_isReading) return;
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
//        Do Something....
    }
}
@end
