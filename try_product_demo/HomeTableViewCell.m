//
//  HomeTableViewCell.m
//  try_product_demo
//
//  Created by Xu on 2017/3/21.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "HomeTableViewCell.h"
@interface HomeTableViewCell()
@property (nonatomic, strong) UILabel* name;
@property (nonatomic, strong) UILabel* price;
@end


@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 20)];
        [self.contentView addSubview:self.name];
        
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 100, 20)];
        [self.contentView addSubview:self.price];
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUserdata:(useKVOData *)userdata {
    _userdata = userdata;
    self.name.text = _userdata.nickname;
    self.price.text = [NSString stringWithFormat:@"%f", _userdata.price];
}

@end
