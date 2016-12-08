//
//  DiagnosticeServices.h
//  AVCamManual
//
//  Created by Donie Kelly on 30/11/2016.
//
//

#import <Foundation/Foundation.h>
#import "ServicesManager.h"

@interface DiagnosticeServices : NSObject

//+ (void) uploadImages:(NSArray *) images completion:(void (^) (BOOL success, NSString *result)) returnBlock;
+(void) post:(NSArray *) images completion:(void (^) (BOOL success, NSString *result)) returnBlock;
@end
