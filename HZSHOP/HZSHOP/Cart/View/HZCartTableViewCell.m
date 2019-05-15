//
//  HZCartTableViewCell.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCartTableViewCell.h"

@implementation HZCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [self initcell];
    
}
#pragma mark 初始化
-(void)initcell
{
    [_selectButton setImage:[UIImage imageNamed:@"radioed.png"] forState:UIControlStateSelected];
    
    [_selectButton setImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    
    [WYFTools viewLayerBorderWidth:1.3 borderColor:RGBACOLOR(201, 201, 201, 1) withView:_numLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done:) name:@"doneAction" object:nil];
    
}

-(void)setCarModel:(HZCartModel *)carModel
{
    _carModel = carModel;
    
    _selectButton.selected = carModel.isSelect;

    _goodsPrice.text = [NSString stringWithFormat:@"￥%@",_carModel.goodsSalesPrice];
    
    _numTextField.text = _carModel.goodsNum;
    
    _goodsTitle.text = _carModel.rootTitle;

    if (_carModel.goodsSpecs != nil) {
    
        _goodsSpecs.text = _carModel.goodsSpecs;

    }
    
    _goodsOldPrice.attributedText = [WYFTools AddCenterLineToView:[NSString stringWithFormat:@"￥%@",_carModel.goodsOldPrice]];
    
    [_imageIcon sd_setImageWithURL:[NSURL URLWithString:_carModel.rootImageUrl] placeholderImage:[UIImage imageNamed:@"appIcon"]];

}

#pragma mark 选择商品
- (IBAction)selectGoods:(UIButton *)sender {

    sender.selected = !sender.selected;
    
    self.carModel.isSelect = sender.selected;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getToalMoney" object:self userInfo:nil];
    
}

#pragma mark + -商品数量
- (IBAction)numClick:(UIButton *)sender {

    NSInteger num = [_numTextField.text integerValue];
    
    if ([_carModel.goodsStockNum integerValue]<=0) {
        
        [JKToast showWithText:@"没有剩余库存"];
        
        return;
        
    }else{
        
        if (sender.tag == 10) {
            
            if (![self.numTextField.text isEqualToString:@"1"]) {
                
                num --;
                
            }else{
                
                [JKToast showWithText:@"数量不能少于1"];
                
                return;
            }
        }else
        {
            num++;
        }
        
        if (num > [_carModel.goodsStockNum integerValue]) {
            
            [JKToast showWithText:@"已达到最大库存限制"];
            
            return;
        }
        
    }
    
    _numTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
    
    _carModel.goodsNum = _numTextField.text;
    
    [self refreshCartList];
    
}

#pragma mark 商品数量输入

- (void)done:(NSNotification *)notification{
    //done按钮的操作
    
    if (_numTextField.text.length > 1) {
        
        NSString *firstStr = [_numTextField.text substringToIndex:1];
        
        if ([firstStr isEqualToString:@"0"]) {
            
            _numTextField.text = [_numTextField.text substringFromIndex:1];
            
        }
        
    }
    
    if ([_carModel.goodsStockNum integerValue] <= 0) {
        
        [JKToast showWithText:@"没有剩余库存"];
        
        return;
        
    }else if ([_numTextField.text integerValue] > [_carModel.goodsStockNum integerValue]){
        
        
        [JKToast showWithText:@"已达到最大库存限制"];
        
        _numTextField.text = [NSString stringWithFormat:@"%ld",[_carModel.goodsStockNum integerValue]];
        
        [self refreshCartList];
        
        return;
        
    }else{
        
        if (_numTextField.text.length > 0) {
            
            _carModel.goodsNum = _numTextField.text;
            
            [self refreshCartList];
            
        }else if ([_numTextField.text isEqualToString:@""] ||[_numTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 || [_numTextField.text isEqualToString:@"0"]){
            
            _numTextField.text = @"1";
            
            _carModel.goodsNum = _numTextField.text;
            
            [self refreshCartList];
            
        }
        
    }
    
}

-(void)refreshCartList
{
    
    NSDictionary *dict = @{@"id":_carModel.rootId,
                           @"total":_numTextField.text
                           };
    
    
    [CrazyNetWork CrazyRequest_Post:EDIT_SHOP_CART parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
      
        LOG(@"刷新购物车", dic);
        
        if (SUCCESS) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getToalMoney" object:self userInfo:nil];

            
        }else{
            
            [JKToast showWithText:dic[@"message"]];
            
        }
        
        
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}
@end
