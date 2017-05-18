//
//  HomeViewModel.m
//  try_product_demo
//
//  Created by Xu on 2017/3/21.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "HomeViewModel.h"
#import "useKVOData.h"

@implementation HomeViewModel

- (void)getData {
    NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:0];
    NSArray* list = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"xujiapan", @"111", nil] forKeys:[NSArray arrayWithObjects:@"nickname", @"price", nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"hahahah", @"222", nil] forKeys:[NSArray arrayWithObjects:@"nickname", @"price", nil]], nil];
    for(NSInteger i = 0; i < list.count; i++) {
        useKVOData* data = [[useKVOData alloc] init];
        data.nickname = [list[i] objectForKey:@"nickname"];
        NSString* price = [list[i] objectForKey:@"price"];
        data.price = price.floatValue;
        [modelArr addObject:data];
    }
    
    self.homesuccess(modelArr);
}

@end
