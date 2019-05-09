//
//  HZGoodsParameterTableViewCell.m
//  HZSHOP
//
//  Created by 英峰 on 2019/5/8.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZGoodsParameterTableViewCell.h"

@implementation HZGoodsParameterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setParameterModel:(HZGoodsParameterModel *)parameterModel
{
    _parameterModel = parameterModel;
    
    for (UIView *view in _bgView.subviews)
    {
        
        [view removeFromSuperview];
    }
    
    //布局tagview并计算高度
    float height = [WYFTools heightWithCreateTagLabel:[UIFont systemFontOfSize:12] tagArray:_parameterModel.parameterArray itemSpace:2 itemHeight:25 currentX:15 currentY:5 superView:_bgView action:@selector(parameterClick:) vc:self buttonUserEnable:YES];
    
    //动态计算当前cell高度
    _parameterModel.cellHeight = height;
    
}

-(void)parameterClick:(UIButton *)sender
{
    
    for (UIView *view in sender.superview.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)view;
            
            [btn setBackgroundColor:[UIColor colorWithHexString:@"#F7F7F7"]];
            
            btn.selected = NO;
            
        }
        
    }
    
    sender.selected = !sender.selected;
    
    [sender setBackgroundColor:[UIColor colorWithHexString:@"#FC585A"]];
    
    if ([self.delegate respondsToSelector:@selector(parameterSelete:sort:)]) {
        
        [self.delegate parameterSelete:[NSString stringWithFormat:@"%ld",sender.tag] sort:_bgView.tag - 99];
        
    }
    
}

@end
