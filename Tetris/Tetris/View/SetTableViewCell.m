//
//  SetTableViewCell.m
//  Tetris
//
//  Created by QSP on 2018/9/2.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "SetTableViewCell.h"
#import "Masonry.h"
#import "CellM.h"

@interface SetTableViewCell ()

@property (weak, nonatomic) UIImageView *iconIV;
@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UILabel *subL;
@property (weak, nonatomic) UIImageView *arrowIV;

@end

@implementation SetTableViewCell

- (QSPTableViewCell *(^)(QSPTableViewCellVM *))cellVMSet {
    return ^(QSPTableViewCellVM *vm){
        super.cellVMSet(vm);
        
        CellM *model = (CellM *)vm.dataM;
        if (![ConFunc blankOfStr:model.icon]) {
            self.iconIV.image = [UIImage imageNamed:model.icon];
        }
        self.titleL.text = model.title;
        [self.titleL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([self.titleL.text sizeWithWidth:CGFLOAT_MAX andFont:self.titleL.font].width + 1));
        }];
        self.subL.text = model.subTitle;
        self.arrowIV.hidden = !model.arrow;
        
        return self;
    };
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconIV = [[UIImageView alloc] init];
        iconIV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:iconIV];
        self.iconIV = iconIV;
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(8);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.equalTo(iconIV.mas_width);
        }];
        
        UIImageView *arrowIV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"arrow"];
        arrowIV.image = image;
        arrowIV.contentMode = UIViewContentModeRight;
        [self.contentView addSubview:arrowIV];
        self.arrowIV = arrowIV;
        [arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-8);
            make.width.equalTo(@(image.size.width));
            make.height.equalTo(@(image.size.height));
        }];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = K_SystemFont(15);
        titleL.textColor = K_GrayColor(51);
        [self.contentView addSubview:titleL];
        self.titleL = titleL;
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconIV.mas_right).offset(8);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-1);
            make.width.equalTo(@(8));
        }];
        
        UILabel *subL = [[UILabel alloc] init];
        subL.font = K_SystemFont(14);
        subL.textColor = K_GrayColor(153);
        subL.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:subL];
        self.subL = subL;
        [subL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleL.mas_right).offset(8);
            make.right.equalTo(arrowIV.mas_left).offset(-8);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-1);
        }];

        UIView *lineV = [[UIView alloc] init];
        lineV.backgroundColor = K_GrayColor(210);
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(8);
            make.right.equalTo(self.contentView).offset(-8);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(0.5));
        }];
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

@end
