//
//  SefvicesManager.h
//  AVCamManual
//
//  Created by Donie Kelly on 30/11/2016.
//
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface ServicesManager : AFHTTPSessionManager

+ (ServicesManager *)shared;

@end
