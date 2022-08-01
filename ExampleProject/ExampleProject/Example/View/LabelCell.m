//
//  LabelCell.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "LabelCell.h"

@implementation LabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return  self;
}

- (void)setupUI
{

    self.lab = [[UILabel alloc] init];
    self.lab.textColor = [TKColorManage systemOrange];
    self.lab.textAlignment = NSTextAlignmentLeft;
    self.lab.font = kFont12;
    [self.contentView addSubview:self.lab];

    _lab.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *view = @{@"view":_lab};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:view]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[view]-0-|" options:0 metrics:nil views:view]];
}

@end
