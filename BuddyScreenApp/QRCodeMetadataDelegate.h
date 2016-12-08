//
//  QRCodeMetadataDelegate.h
//  AVCamManual
//
//  Created by Donie Kelly on 30/11/2016.
//
//

@import AVFoundation;

@protocol QRCodeCaptureDelegate <NSObject>
-(void) foundTagcode:(NSString *)tagcode andChirpID:(NSString *)chirpID;
@end

@interface QRCodeMetadataDelegate : NSObject <AVCaptureMetadataOutputObjectsDelegate>

@property id<QRCodeCaptureDelegate> delegate;

@end
