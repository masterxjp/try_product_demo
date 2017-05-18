//
//  UserManager.h
//  try_product_demo
//
//  Created by Xu on 2017/3/2.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

+(instancetype) shareInstance;
-(NSString* )userid;
@end
