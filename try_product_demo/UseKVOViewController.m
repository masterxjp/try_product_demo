//
//  UseKVOViewController.m
//  try_product_demo
//
//  Created by Xu on 2017/3/2.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "UseKVOViewController.h"
#import "useKVOData.h"

@interface UseKVOViewController () {
    float count;
}
@property(nonatomic, strong) useKVOData* useKVO;
@property(nonatomic, strong) IBOutlet UILabel* nameLabel;
@property(nonatomic, strong) IBOutlet UILabel* priceLabel;

@end

@implementation UseKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    count = 10;
    
    self.useKVO = [[useKVOData alloc] init];
    
    [self.useKVO addObserver:self forKeyPath:@"nickname" options:NSKeyValueObservingOptionNew context:NULL];
    [self.useKVO addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.nameLabel.text = @"111";
    self.priceLabel.text = [NSString stringWithFormat:@"%.1f", count];
    

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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"nickname"]) {
        self.nameLabel.text = [self.useKVO valueForKey:@"nickname"];
    }
    else if([keyPath isEqualToString:@"price"]) {
        self.priceLabel.text = [NSString stringWithFormat:@"%.1f", [[self.useKVO valueForKey:@"price"] floatValue]];
    }
    else {
        //若当前类无法捕捉到这个KVO，那很有可能是在他的superClass，或者super-superClass...中,预防父类也有自己绑定的一些其他KVO
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (IBAction)buttonAction:(id)sender
{
    count = count + 1;
    [self.useKVO setValue:[NSNumber numberWithFloat:count] forKey:@"price"];
    [self.useKVO setValue:@"许嘉攀" forKey:@"nickname"];
}

- (void)dealloc {
    [self.useKVO removeObserver:self forKeyPath:@"nickname"];
    [self.useKVO removeObserver:self forKeyPath:@"price"];
}

@end
