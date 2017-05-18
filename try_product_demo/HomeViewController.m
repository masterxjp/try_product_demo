//
//  HomeViewController.m
//  try_product_demo
//
//  Created by Xu on 2017/3/21.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSArray* array;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView* tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 80.0f;
    [self.view addSubview:tableview];
    [tableview registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    
    HomeViewModel* homeViewModel = [[HomeViewModel alloc] init];
    homeViewModel.homesuccess = ^(id value) {
        self.array = value;
        [tableview reloadData];
    };
    
    [homeViewModel getData];
    
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    cell.userdata = self.array[indexPath.row];
    
    return cell;
}

@end
