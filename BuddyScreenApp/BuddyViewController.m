//
//  ViewController.m
//  IPDFCameraViewController
//
//  Created by Maximilian Mackh on 11/01/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

@import AVFoundation;
#import "BuddyViewController.h"
#import "QRCodeMetadataDelegate.h"
#import "IPDFCameraViewController.h"
#import "ChirpSDK/ChirpSDK.h"

@interface BuddyViewController () <QRCodeCaptureDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet IPDFCameraViewController *cameraViewController;
@property (weak, nonatomic) IBOutlet UIImageView *focusIndicator;

- (IBAction)focusGesture:(id)sender;
- (IBAction)captureButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *scanQRButton;

@end

@implementation BuddyViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.cameraViewController setupCameraView];
    
    // Activate Chirp.io
    [[ChirpSDK sdk] setAppKey:@"oea5PoKMIBDLdCS0odHNezUvR" andSecret:@"KK4tDFffcNqIwu03aWg47WmGUWrf21iRhzEX3cYQEW96PDTXqR" withCompletion:^(BOOL authenticated, NSError * _Nullable error) {
        
        if(authenticated)
            NSLog(@"Chirp authenticated: %@", [[ChirpSDK sdk] version]);
        else
            NSLog(@"Chirp error: %@", error);
    }];

    [[ChirpSDK sdk] setProtocolNamed:ChirpProtocolNameUltrasonic];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Start barcode scan first
    [self scanBarcode:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.cameraViewController stopRectangleDetection];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark CameraVC Actions

- (IBAction)focusGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        CGPoint location = [sender locationInView:self.cameraViewController];
        
        [self focusIndicatorAnimateToPoint:location];
        
        [self.cameraViewController focusAtPoint:location completionHandler:^
         {
             [self focusIndicatorAnimateToPoint:location];
         }];
    }
}

- (void)focusIndicatorAnimateToPoint:(CGPoint)targetPoint
{
    [self.focusIndicator setCenter:targetPoint];
    self.focusIndicator.alpha = 0.0;
    self.focusIndicator.hidden = NO;
    
    [UIView animateWithDuration:0.4 animations:^
    {
         self.focusIndicator.alpha = 1.0;
    }
    completion:^(BOOL finished)
    {
         [UIView animateWithDuration:0.4 animations:^
         {
             self.focusIndicator.alpha = 0.0;
         }];
     }];
}

#pragma mark -
#pragma mark CameraVC Capture Image

- (IBAction)captureButton:(id)sender
{
    __weak typeof(self) weakSelf = self;
    
    [self.cameraViewController captureImageWithCompletionHander:^(NSString *imageFilePath)
    {
        UIImageView *captureImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imageFilePath]];
        captureImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        captureImageView.frame = CGRectOffset(weakSelf.view.bounds, 0, -weakSelf.view.bounds.size.height);
        captureImageView.alpha = 1.0;
        captureImageView.contentMode = UIViewContentModeScaleAspectFit;
        captureImageView.userInteractionEnabled = YES;
        [weakSelf.view addSubview:captureImageView];
        
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(dismissPreview:)];
        [captureImageView addGestureRecognizer:dismissTap];
        
        [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.7 options:UIViewAnimationOptionAllowUserInteraction animations:^
        {
            captureImageView.frame = weakSelf.view.bounds;
        } completion:nil];
    }];
}

- (void)dismissPreview:(UITapGestureRecognizer *)dismissTap
{
    [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^
    {
        dismissTap.view.frame = CGRectOffset(self.view.bounds, 0, self.view.bounds.size.height);
    }
    completion:^(BOOL finished)
    {
        [dismissTap.view removeFromSuperview];
    }];
}

- (IBAction)scanBarcode:(id)sender {

    [self.cameraViewController stopRectangleDetection];
    [self.cameraViewController addQRDetector:self];
    
    self.scanQRButton.enabled = NO;
}


-(void) foundTagcode:(NSString *)tagcode andChirpID:(NSString *)chirpID;
{
    // Finished with qr code for now
    [self.cameraViewController removeQRDetector];
    
    // Start rectangle detection
    [self.cameraViewController startRectangleDetection];
    
    NSLog(@"Chirping %@ for tagcode %@", chirpID, tagcode);
    
    Chirp *chirp = [[Chirp alloc] initWithIdentifier:chirpID];
    [chirp chirp];
    
    self.scanQRButton.enabled = YES;
    
}

@end
