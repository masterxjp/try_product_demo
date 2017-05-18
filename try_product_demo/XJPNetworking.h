//
//  XJPNetworking.h
//  try_product_demo
//
//  Created by Xu on 2017/3/23.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NetStatus)
{
    UNKOWN = 0,
    NOTREACHABLE,
    WWAN,
    WIFI
};

@interface XJPNetworking : NSObject


/**
 GET请求

 @param urlString URL
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 @param progress 进度
 */
+(void)GET:(NSString *)urlString parameters:(id)parameters success:(void(^)(id success))success failure:(void(^)(NSError *failure))failure progress:(void(^)(float progress))progress;


/**
 POST请求

 @param urlString URL
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 @param progress 进度
 */
+(void)POST:(NSString *)urlString parameters:(id)parameters success:(void(^)(id success))success failure:(void(^)(NSError *failure))failure progress:(void(^)(float progress))progress;


/**
 实时监测网络变化

 @param netstatus 当前网络状态
 */
+(void)ReachabilityStatus:(void(^)(NSUInteger status))netstatus;

@end
