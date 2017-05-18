//
//  UserManager.m
//  try_product_demo
//
//  Created by Xu on 2017/3/2.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+(instancetype) shareInstance {
    static UserManager* usermanager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        usermanager = [[UserManager alloc] init];
    });
    
    return usermanager;
}


-(NSString* )userid {
    return @"1234";
}

@end
