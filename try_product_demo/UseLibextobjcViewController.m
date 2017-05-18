//
//  UseLibextobjcViewController.m
//  try_product_demo
//
//  Created by Xu on 2017/3/2.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "UseLibextobjcViewController.h"
#import <libextobjc/EXTScope.h>

@interface UseLibextobjcViewController ()
@property (nonatomic, copy) dispatch_block_t block;
@property (nonatomic, strong) NSString *str;

@property (nonatomic, strong) IBOutlet UILabel* messageLabel;
@end

@implementation UseLibextobjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILabel* pLabel = [[UILabel alloc] init];
    pLabel.frame = CGRectMake(0, 0, 100, 30);
    pLabel.text = @"循环引用";
    pLabel.textAlignment = NSTextAlignmentCenter;
    pLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = pLabel;
    
    self.messageLabel.text = @"调用Pods里面的libextobjc第三方库来解决循环引用";
    
    [self callLibextobjcMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 * 使用@weakify和@strongify，解决block循环引用问题的事例
 */
- (void)callLibextobjcMethod {
    
    self.str = @"111";
    
    @weakify(self)
    self.block = ^{
        @strongify(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", self.str);
        });
    };
    self.block();
}

-(void)dealloc {
    
}

@end
