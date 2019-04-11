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
-(void)initcell
{
    [_selectButton setImage:[UIImage imageNamed:@"radioed.png"] forState:UIControlStateSelected];
    
    [_selectButton setImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    
    [WYFTools viewLayer:4 withView:_numLabel];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor blackColor] withView:_numLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done:) name:@"doneAction" object:nil];
    
}
-(void)setCarModel:(HZCartModel *)carModel
{
    _carModel = carModel;
    
    _selectButton.selected = carModel.isSelect;

    _goodsPrice.text = _carModel.goodssalesprice;
    
    _numTextField.text = _carModel.goodsnum;
    
    _goodsTitle.text = _carModel.goodstitle;
    
}
- (IBAction)selectGoods:(UIButton *)sender {

    sender.selected = !sender.selected;
    
    self.carModel.isSelect = sender.selected;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getToalMoney" object:self userInfo:nil];
    
}
- (IBAction)numClick:(UIButton *)sender {

    
}
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
            
            _carModel.goodsnum = _numTextField.text;
            
            [self refreshCartList];
            
        }else if ([_numTextField.text isEqualToString:@""] ||[_numTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 || [_numTextField.text isEqualToString:@"0"]){
            
            _numTextField.text = @"1";
            
            _carModel.goodsnum = _numTextField.text;
            
            [self refreshCartList];
            
        }
        
    }
    
}
-(void)refreshCartList
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getToalMoney" object:self userInfo:nil];
    
}
@end
