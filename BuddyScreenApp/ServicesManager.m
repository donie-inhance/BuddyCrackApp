//
//  ServicesManager.m
//  AVCamManual
//
//  Created by Donie Kelly on 30/11/2016.
//
//

#import "ServicesManager.h"

@implementation ServicesManager

static ServicesManager *_sharedManager = nil;

+ (ServicesManager*) shared {
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc]  init];
    });
    
    [_sharedManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [_sharedManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [_sharedManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return _sharedManager;
}

@end
