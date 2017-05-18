//
//  RootOneViewController.m
//  try_product_demo
//
//  Created by Xu on 2016/10/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "RootOneViewController.h"
#import <Masonry.h>

/*
 提示:
 使用Pods里面的Masonry第三方库，使用代码实现自动布局
 */

@interface RootOneViewController ()

@end

@implementation RootOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILabel* pLabel = [[UILabel alloc] init];
    pLabel.frame = CGRectMake(0, 0, 100, 30);
    pLabel.text = @"自动布局";
    pLabel.textAlignment = NSTextAlignmentCenter;
    pLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = pLabel;
    
    
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    UIView* subview = [[UIView alloc] init];
    subview.backgroundColor = [UIColor redColor];
    [view addSubview:subview];
    
    UIView* subview1 = [[UIView alloc] init];
    subview1.backgroundColor = [UIColor redColor];
    [view addSubview:subview1];
    
    int padding = 10;
    [subview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(view.mas_left).with.offset(padding);
        make.right.mas_equalTo(subview1.mas_left).with.offset(-padding);
        make.height.mas_equalTo(@150);
        make.width.mas_equalTo(subview1);
        
    }];
    
    [subview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(subview.mas_right).with.offset(padding);
        make.right.mas_equalTo(view.mas_right).with.offset(-padding);
        make.height.mas_equalTo(@150);
        make.width.mas_equalTo(subview);
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
