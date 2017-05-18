//
//  XJPNetworking.m
//  try_product_demo
//
//  Created by Xu on 2017/3/23.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "XJPNetworking.h"
#import <AFNetworking.h>
#import "XJPNetConfig.h"


@implementation XJPNetworking

+(void)GET:(NSString *)urlString parameters:(id)parameters success:(void(^)(id success))success failure:(void(^)(NSError *failure))failure progress:(void(^)(float progress))progress {
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    manager.requestSerializer.timeoutInterval = 5.0f;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/xml", nil];
    
    [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+(void)POST:(NSString *)urlString parameters:(id)parameters success:(void(^)(id success))success failure:(void(^)(NSError *failure))failure progress:(void(^)(float progress))progress {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5.0f;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+(void)ReachabilityStatus:(void(^)(NSUInteger status))netstatus {
    AFNetworkReachabilityManager* manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                netstatus(UNKOWN);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netstatus(NOTREACHABLE);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netstatus(WWAN);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netstatus(WIFI);
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

@end
