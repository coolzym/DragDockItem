//
//  ButtonArray.m
//  DragDockItem
//
//  Created by zhang minzhang min on 15/12/23.
//  Copyright © 2015年 zhang min. All rights reserved.
//

#import "ButtonItem.h"
#import "MyButton.h"

//按钮总数量
#define kButtonCount 13

static ButtonItem *SharedInstance;

@interface ButtonItem()

@property (strong,nonatomic) NSMutableArray *arrayM; /*!< 最终的集合 */
@property (strong,nonatomic) NSMutableArray *titleArrayM; /*!< 按钮文字集合 */
@property (strong,nonatomic) NSMutableArray *imageArrayM; /*!< 按钮图片集合 */
@property (strong,nonatomic) NSMutableArray *buttonArrayM; /*!< 按钮集合 */

@end

@implementation ButtonItem

#pragma mark - private method

/**
 *  改变字典中按钮的标识
 *
 *  @param oneButton 要改变的按钮
 *  @param twoButton 要改变的按钮
 */
-(void)changeButtonFlagWithOneButton:(MyButton *)oneButton twoButton:(MyButton *)twoButton
{
    [self.arrayM exchangeObjectAtIndex:oneButton.sort withObjectAtIndex:twoButton.sort];
    
    NSInteger i = 0;
    
    for (NSMutableDictionary *dict in self.arrayM) {
        MyButton *button = dict[self.buttonDictKey];
        NSInteger buttonFlag = [dict[self.buttonFlagDictKey] integerValue];
        
        [button setUserInteractionEnabled:YES];
        
        if ([oneButton isEqual:button] || [twoButton isEqual:button]) {
            if (buttonFlag) {
                buttonFlag = 0;
            }
            else{
                buttonFlag = 1;
            }
            
            button.sort = i;
            
            [dict setValue:button forKey:self.buttonDictKey];
            [dict setValue:@(buttonFlag) forKey:self.buttonFlagDictKey];
            
        }
        
        i++;
    }
}

#pragma mark - Get and Set
-(NSArray *)buttonArray
{
    return self.arrayM;
}

-(NSString *)buttonDictKey
{
    return @"button";
}

-(NSString *)buttonFlagDictKey
{
    return @"buttonflag";
}

-(NSMutableArray *)arrayM
{
    if (!_arrayM) {
        _arrayM = [NSMutableArray array];
        
        //默认前4个是底部按钮
        for (NSInteger i = 0; i < kButtonCount; i++) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
            
            [dict setValue:self.buttonArrayM[i] forKey:@"button"];
            
            NSInteger flag = 0;
            
            if (i < 4) {
                flag = 1;
            }
            
            [dict setValue:@(flag) forKey:@"buttonflag"];
            
            [_arrayM addObject:dict];
        }
    }
    
    return _arrayM;
}

-(NSMutableArray *)buttonArrayM
{
    if (!_buttonArrayM) {
        _buttonArrayM = [NSMutableArray array];
        
        for (NSInteger i = 0; i < kButtonCount; i++) {
            MyButton *button = [[MyButton alloc]initWithImage:self.imageArrayM[i] title:self.titleArrayM[i]];
            button.sort = i;
            
            [_buttonArrayM addObject:button];
        }
    }
    
    return _buttonArrayM;
}

-(NSMutableArray *)imageArrayM
{
    if (!_imageArrayM) {
        _imageArrayM = [NSMutableArray array];
        
        for (NSInteger i = 0; i < kButtonCount; i++) {
            NSString *imageName = [NSString stringWithFormat:@"a%ld",i + 1];
            
            UIImage *image = [UIImage imageNamed:imageName];
            
            [_imageArrayM addObject:image];
        }
    }
    
    return _imageArrayM;
}

-(NSMutableArray *)titleArrayM
{
    if (!_titleArrayM) {
        _titleArrayM = [NSMutableArray array];
        
        [_titleArrayM addObject:@"首页"];
        [_titleArrayM addObject:@"发现"];
        [_titleArrayM addObject:@"中心"];
        [_titleArrayM addObject:@"其他"];
        [_titleArrayM addObject:@"测试"];
        [_titleArrayM addObject:@"广场"];
        [_titleArrayM addObject:@"商品"];
        [_titleArrayM addObject:@"查询"];
        [_titleArrayM addObject:@"日志"];
        [_titleArrayM addObject:@"地区"];
        [_titleArrayM addObject:@"订单"];
        [_titleArrayM addObject:@"图库"];
        [_titleArrayM addObject:@"分站"];
    }
    
    return _titleArrayM;
}

#pragma mark - 单例设置
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [super allocWithZone:zone];
    });
    
    return SharedInstance;
}

+(ButtonItem *)sharkButtonItem
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [[ButtonItem alloc]init];
    });
    
    return SharedInstance;
}


@end
