//
//  DiagnosticeServices.m
//  AVCamManual
//
//  Created by Donie Kelly on 30/11/2016.
//
//

#import "DiagnosticeServices.h"

@implementation DiagnosticeServices

+ (void) uploadImages:(NSArray *) images completion:(void (^) (BOOL success, NSString *result)) returnBlock {
    
    __block NSString *result;
    NSString *url = [NSString stringWithFormat:@"%@/api/v4/diagnostics/%@/multiScreenTestImage", @"https://alpha.yougetitback.com", @"131163292639320"];
    
    ServicesManager *manager = [ServicesManager shared];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    __block int count = 0;
    
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in images)
        {
            if(count == 0)
                [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1.0) name:@"image" fileName:@"white" mimeType:@"image/jpeg"];
            else if(count == 1)
                [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"image" fileName:@"red" mimeType:@"image/jpeg"];
            else if(count == 2)
                [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"image" fileName:@"green" mimeType:@"image/jpeg"];
            else if(count == 3)
                [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"image" fileName:@"blue" mimeType:@"image/jpeg"];
            count++;
        }
        
    } success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull responseObject) {
        
        
        NSNumber* cracked = [responseObject objectForKey:@"Cracked"];
        if(cracked != nil)
        {
            
            
            if(cracked.integerValue == 1)
                result = @"fail";
            else if(cracked.integerValue == 0)
                result = @"pass";
            else
                result = @"unknown";
        }
        else
        {
            result = @"unknown";
        }
        returnBlock(YES, result);
        
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        returnBlock(NO, @"unknown");
    }];
}

+(void) post:(NSArray *) images completion:(void (^) (BOOL success, NSString *result)) returnBlock
{
    NSString *url = [NSString stringWithFormat:@"/api/v4/diagnostics/%@/multiScreenTestImage", @"131163292639320"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://alpha.yougetitback.com"]];
    [manager.requestSerializer setTimeoutInterval:500];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
    
        [formData appendPartWithFileData:images[0]
                                name:@"image"
                            fileName:@"white"
                            mimeType:@"image/jpeg"];
    
    }
    progress:^(NSProgress *uploadProgress) {
        
        NSLog(@"Uploading: %.0f", uploadProgress.fractionCompleted * 100);
    }
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        if (responseObject != nil)
        {
            NSString *result;
            NSNumber* cracked = [responseObject objectForKey:@"Cracked"];
            if(cracked != nil)
            {
                if(cracked.integerValue == 1)
                    result = @"fail";
                else if(cracked.integerValue == 0)
                    result = @"pass";
                else
                    result = @"unknown";
            }
            else
            {
                result = @"unknown";
            }
            returnBlock(YES, result);
            
        }
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        returnBlock(NO, @"timeout");
    }];
}
@end

