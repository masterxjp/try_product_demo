//
//  HomeViewModel.h
//  try_product_demo
//
//  Created by Xu on 2017/3/21.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HomeSuccess)(id value);

@interface HomeViewModel : NSObject

@property(nonatomic, copy) HomeSuccess homesuccess;

-(void)getData;
@end
