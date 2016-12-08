//
//  QRCodeMetadataDelegate.m
//  AVCamManual
//
//  Created by Donie Kelly on 30/11/2016.
//
//

#import "QRCodeMetadataDelegate.h"

@implementation QRCodeMetadataDelegate


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeQRCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes)
        {
            if ([metadata.type isEqualToString:type])
            {
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                NSLog(@"QRCode: %@", detectionString);
                [self parseQR:detectionString];
                break;
            }
        }
    }
}

-(void) parseQR:(NSString *)qrString
{
    NSArray* stringComponents = [qrString componentsSeparatedByString:@":"];
    if(stringComponents.count == 2)
    {
        if(self.delegate)
            [self.delegate foundTagcode:stringComponents[0] andChirpID:stringComponents[1]];
    }
}

@end
