//
//  RootViewController.m
//  try_product_demo
//
//  Created by Xu on 2016/10/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "RootViewController.h"
#import "RootOneViewController.h"
#import "UseLibextobjcViewController.h"
#import "UseKVOViewController.h"
#import "HomeViewController.h"


@interface RootViewController ()
{
    IBOutlet UITableView* tableview;
    NSArray* datalist;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    datalist = [NSArray arrayWithObjects:@"Masonry自动布局", @"毛玻璃效果", @"循环引用问题", @"KVO使用", @"MVVM", nil];
    
    //设置tableview的分割线的颜色和左边15个单位的空白
//    tableview.separatorColor = [UIColor redColor];
    tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.1
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datalist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.textLabel.text = [datalist objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog([datalist objectAtIndex:indexPath.row], nil);
    
    if([indexPath row] == 0) {
        RootOneViewController* rootOne = [[RootOneViewController alloc] initWithNibName:@"RootOneViewController" bundle:nil];
        rootOne.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rootOne animated:YES];
    }
    else if([indexPath row] == 1) {
        
    }
    else if([indexPath row] == 2) {
        UseLibextobjcViewController* uselibextobjc = [[UseLibextobjcViewController alloc] initWithNibName:@"UseLibextobjcViewController" bundle:nil];
        uselibextobjc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:uselibextobjc animated:YES];
    }
    else if([indexPath row] == 3) {
        UseKVOViewController* useKVO = [[UseKVOViewController alloc] initWithNibName:@"UseKVOViewController" bundle:nil];
        useKVO.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:useKVO animated:YES];
    }
    else if([indexPath row] == 4) {
        HomeViewController* home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        home.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:home animated:YES];
    }

}

@end
