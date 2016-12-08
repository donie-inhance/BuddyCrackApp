//
//  IPDFCameraViewController.h
//  InstaPDF
//
//  Created by Maximilian Mackh on 06/01/15.
//  Copyright (c) 2015 mackh ag. All rights reserved.
//

@import UIKit;
@import AVFoundation;
#import "QRCodeMetadataDelegate.h"

typedef NS_ENUM(NSInteger,IPDFCameraViewType)
{
    IPDFCameraViewTypeBlackAndWhite,
    IPDFCameraViewTypeNormal
};

@interface IPDFCameraViewController : UIView

@property (nonatomic,strong) AVCaptureSession *captureSession;
@property (nonatomic,strong) AVCaptureMetadataOutput *qrCodeMeta;

-(void) addQRDetector:(id<QRCodeCaptureDelegate>)delegate;
-(void) removeQRDetector;


- (void)setupCameraView;

- (void)startRectangleDetection;
- (void)stopRectangleDetection;

@property (nonatomic,assign) BOOL enableBorderDetection;
@property (nonatomic,assign,getter=isTorchEnabled) BOOL enableTorch;

@property (nonatomic,assign) IPDFCameraViewType cameraViewType;

- (void)focusAtPoint:(CGPoint)point completionHandler:(void(^)())completionHandler;

- (void)captureImageWithCompletionHander:(void(^)(NSString *imageFilePath))completionHandler;

@end
